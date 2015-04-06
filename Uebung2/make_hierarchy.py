__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure

from xml.etree import ElementTree
from xml.dom import minidom

def prettifyXML(elem):
    rough_string = ElementTree.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent=" ")

renameTag = {
    'level2' : 'studybranch',
    'level3' : 'study',
    'level4' : 'modulegroup',
    'level5' : 'modulesubgroup',  # module if no subsequent level6
    'level6' : 'module',
}
currentLevel5Type = None  # either leaf or node

outroot = ElementTree.Element('lectureindex')
currentElem = [outroot] # stack mirrors hierarchy of current hierarchy
def add_contents(e):
    anchor = e.attrib['anker']
    #if anchor:
    #    e.set('anchor1', anchor)
    xpath = ('.//*[@id="%s"]' % anchor[1:])
    ##print(xpath, end="")
    chap = rootElem.find(xpath)
    #if chap:
    #    e.append(chap)

def new_level(e):
    ##print("%s<%s anchor=%s>" % (indent, e.tag, e.attrib['anker']), end="")
    currentElem[-1].append(e)  # append to xml (etree)
    #ElementTree.SubElement(currentElem[-1], e.tag) # append empty element to xml (etree)
    currentElem.append(e)  # append to level stack
    add_contents(e)

levelList = []
rootElem = ElementTree.parse('vlz_kap_706 frag.xml').getroot()
for e in rootElem.findall('*'):
    if e.tag.startswith('level'):
        levelList.append(e)
levelList.append(ElementTree.Element('level0')) # terminating element
    
''' 3 jobs in one:
1. create hierarchy from linear list by inserting close tags at the appropriate location
2. rename levelN tag to specific name (see renameTag)
3. skip level5 modulesubgroups if no level6 existing:
   a new level is a module if not level6 follows (i.e. "leaf")
   a level 4 must close the previous level 5 according to its type
'''
levelStack = [0]
prevLevel = 0
currentLevel5Type = None
for pos, e in enumerate(levelList):
    if pos == len(levelList) - 1: break
    currLevel = int(e.tag[-1])  # get last char - lt 10 levels in input
    nextLevel = int(levelList[pos+1].tag[-1])
    if currLevel == 5 and nextLevel != 6:
        e.tag = renameTag['level6']  # no modulesubgroup
        currentLevel5Type = 'leaf'
    elif currLevel == 5 and nextLevel == 6:
        e.tag = renameTag['level5']
        currentLevel5Type = 'node'
    else:
        e.tag = renameTag[e.tag]
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

outTree = ElementTree.ElementTree(outroot)
outTree.write('z.xml', encoding='utf-8')
print(prettifyXML(outroot))