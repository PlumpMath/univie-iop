__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure

from xml.etree import ElementTree
from xml.dom import minidom
import re

def prettifyXML(elem):
    rough_string = ElementTree.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent=" ")

def rename_element(e, currLevel, nextLevel):
    renameTag = {
        'level2' : 'studybranch',
        'level3' : 'study',
        'level4' : 'modulegroup',
        'level5' : 'modulesubgroup',  # module if no subsequent level6
        'level6' : 'module',
    }
    if currLevel == 5 and nextLevel != 6:
        e.tag = renameTag['level6']  # no modulesubgroup
    elif currLevel == 5 and nextLevel == 6:
        e.tag = renameTag['level5']
    else:
        e.tag = renameTag[e.tag]

def add_attr_and_children(newElem, e):
    anchor = e.attrib['anker'][1:]
    if anchor:
        newElem.set('id', anchor)
    newElem.set('name', e.attrib.get('name', ''))
    if e.tag == 'module':
        xpath = ('.//*[@id="%s"]/vlvz' % anchor)
        vlvz = inRoot.find(xpath)
        if vlvz:
            ElementTree.SubElement(newElem, 'course')
            course = newElem[0]
            course.set('type', vlvz.attrib.get('typ', ''))
            course.set('ects', re.sub('\\s', '', vlvz.attrib.get('ects', '')))
            course.set('hoursPerWeek', vlvz.attrib.get('wochenstunden', ''))
            x = {'N':'No', 'Y':'Yes', '?':''}
            course.set('pruefungsimmanent', x[vlvz.attrib.get('pruefungsimmanent', '?')])
            course.set('title', vlvz.attrib.get('kurztitel', ''))
            #newElem.set('', vlvz.attrib.get('', ''))

### Attribute von <vlvz>


def new_level(e):
    newElem = ElementTree.Element(e.tag)
    currentElem[-1].append(newElem)  # append to xml (etree)
    currentElem.append(newElem)  # append to level stack
    add_attr_and_children(newElem, e)

''' --- main ---
'''
inRoot = ElementTree.parse('vlz_kap_706 frag.xml').getroot()
levelList = []

for e in inRoot.findall('*'):
    if e.tag.startswith('level'):
        levelList.append(e)
levelList.append(ElementTree.Element('level0')) # terminating element
    
''' 1. create hierarchy from linear list by inserting close tags at the appropriate location
    2. skip level5 modulesubgroups if no level6 existing:
       a new level is a module if no level6 follows (i.e. "leaf")
       a level 4 must close the previous level 5 according to its type
'''
outRoot = ElementTree.Element('lectureindex')
currentElem = [outRoot] # stack mirrors hierarchy of current hierarchy
levelStack = [0]
prevLevel = 0
for pos, e in enumerate(levelList):
    if pos == len(levelList) - 1: break
    currLevel = int(e.tag[-1])  # get last char - lt 10 levels in input
    nextLevel = int(levelList[pos+1].tag[-1])
    rename_element(e, currLevel, nextLevel)
    prevLevel = int(levelStack[-1]) # get last element in list
    if currLevel == prevLevel:
        currentElem.pop()
        new_level(e)
    elif currLevel > prevLevel:
        levelStack.append(currLevel)
        new_level(e)
    elif currLevel < prevLevel:
        currentElem.pop()
        levelStack.pop()
        for d in reversed(range(currLevel, prevLevel)):
            currentElem.pop()
        new_level(e)

outTree = ElementTree.ElementTree(outRoot)
outTree.write('z.xml', encoding='utf-8')
print(prettifyXML(outRoot))