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

def new_level(e):
    newElem = ElementTree.Element(e.tag)
    currentElem[-1].append(newElem)  # append to xml (etree)
    currentElem.append(newElem)  # append to level stack
    add_attr_and_children(newElem, e)

def add_attr_and_children(newElem, e):
    anchor = e.attrib['anker'][1:]
    if anchor:
        newElem.set('id', anchor)
    newElem.set('name', e.attrib.get('name', '?'))
    if e.tag == 'module':
        add_course(newElem, e, anchor)

def add_course(newElem, e, anchor):
    xpath = ('.//*[@id="%s"]/vlvz' % anchor)
    vlvz = inRoot.findall(xpath)
    for i, v in enumerate(vlvz):
        ElementTree.SubElement(newElem, 'course')
        course = newElem[i]
        lvnr = v.attrib.get('lvnr', '?')
        course.set('id', lvnr)
        course.set('type', v.attrib.get('typ', '?'))
        course.set('ects', re.sub('\\s', '', v.attrib.get('ects', '?')))
        course.set('hoursPerWeek', v.attrib.get('wochenstunden', '?'))
        xYN = {'N':'No', 'Y':'Yes', '?':''}
        course.set('continousassessment', xYN[v.attrib.get('pruefungsimmanent', '?')])
        course.set('title', v.attrib.get('kurztitel', '?'))
        add_group(course, lvnr)

def add_group(course, lvnr):
        xpath = './/*[@lvnr="%s"]/gruppen' % lvnr
        gruppen = inRoot.findall(xpath)
        for i, g in enumerate(gruppen):
            ElementTree.SubElement(course, 'group')
            group = course[i]
            xBN = {'N':'No', 'B':'Yes', '':'No'}
            group.set('block', xBN[g.attrib.get('block', '?')])
            group_id = g.attrib.get('gruppe', '?')
            group.set('id', group_id)
            group.set('learningplatform', g.attrib.get('plattform', '?'))
            group.set('learningplatformurl', g.attrib.get('kurs_link', '?'))
            xYN = {'N':'No', 'Y':'Yes', '?':''}
            group.set('livestream', xYN[g.attrib.get('livestream', '?')])
            group.set('signlanguage', xYN[g.attrib.get('gebaerdensprache', '?')])
            ElementTree.SubElement(group, 'courselanguages')
            add_languages(group[0], lvnr, group_id)
            ElementTree.SubElement(group, 'appointments')
            add_appointments(group[1], lvnr, group_id)
            ElementTree.SubElement(group, 'lecturers')
            add_lecturers(group[2], lvnr, group_id)

def add_languages(parent, lvnr, group_id):
        xpath = './/*[@lvnr="%s"]/gruppen[@gruppe="%s"]/unterrichtssprachen' % (lvnr, group_id)
        sprachen = inRoot.findall(xpath)
        for i, s in enumerate(sprachen):
            ElementTree.SubElement(parent, 'lang')
            lang = parent[i]
            lang.text = s.text

def add_appointments(parent, lvnr, group_id):
        xpath = './/*[@lvnr="%s"]/gruppen[@gruppe="%s"]/von_bis' % (lvnr, group_id)
        von_bis = inRoot.findall(xpath)
        for i, vb in enumerate(von_bis):
            ElementTree.SubElement(parent, 'appointment')
            apptmnt = parent[i]
            apptmnt.set('date', vb.attrib.get('datum', '?')[:11])
            apptmnt.set('start', vb.attrib.get('beginn', '?'))
            apptmnt.set('end', vb.attrib.get('ende', '?'))
            apptmnt.set('room', vb.attrib.get('kurzraumname', '?'))
            apptmnt.set('location', vb.attrib.get('ort', '?'))
            apptmnt.set('zip', vb.attrib.get('plz', '?'))
            apptmnt.set('street', vb.attrib.get('strasse', '?'))

def add_lecturers(parent, lvnr, group_id):
        xpath = './/*[@lvnr="%s"]/gruppen[@gruppe="%s"]/vortragende' % (lvnr, group_id)
        vortragende = inRoot.findall(xpath)
        for i, vt in enumerate(vortragende):
            ElementTree.SubElement(parent, 'lecturer')
            lect = parent[i]
            lect.set('givenname', vt.attrib.get('vorname', '?'))
            lect.set('surname', vt.attrib.get('zuname', '?'))
            lect.set('role', vt.attrib.get('rolle_person', '?'))




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
outTree.write('vlz_kap_706_clean.xml', encoding='utf-8')
print(prettifyXML(outRoot))