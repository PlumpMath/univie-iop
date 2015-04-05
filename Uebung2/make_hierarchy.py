__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure
import xml.etree.ElementTree

renameTag = {
    'level2' : 'studybranch',
    'level3' : 'study',
    'level4' : 'modulegroup',
    'level5' : 'modulesubgroup',  # module if no subsequent level6
    'level6' : 'module',
}
prevLevel5Type = None  # either leaf or node

def close_level(l, indent, prevLevel5Type):
    #if l == 4 and prevLevel5Type == 'leaf':
    #    print("%s</level%s>" % (indent, 6))
    print("%s</level%s>" % (indent, l))

def add_contents(e, indent=''):
    anchor = e.attrib['anker'][1:]
    xpath = ('.//*[@id="%s"]' % anchor)
    ##print(xpath, end="")
    chap = rootElem.find(xpath)
    if chap:
        print("\n  %s<%s" % (indent, chap.tag), end="")
        for k, v in chap.attrib.items():
            print(' %s="%s"' %(k, v), end="")
        print("/>", end="")

def new_level(e, indent=''):
    ##print("%s<%s anchor=%s>" % (indent, e.tag, e.attrib['anker']), end="")
    print("%s<%s>" % (indent, e.tag), end="")
    #add_contents(e, indent)

levelList = []
rootElem = xml.etree.ElementTree.parse('vlz_kap_706 frag.xml').getroot()
for e in rootElem.findall('*'):
    if e.tag.startswith('level'):
        levelList.append(e)
levelList.append(xml.etree.ElementTree.Element('level0')) # terminating element
    
''' 3 jobs in one:
1. create hierarchy from linear list by inserting close tags at the appropriate location
2. rename levelN tag to specific name (see renameTag)
3. skip level5 modulesubgroups if no level6 existing:
   a new level is a module if not level6 follows (i.e. "leaf")
   a level 4 must close the previous level 5 according to its type
'''
levelStack = [0]
prevLevel = 0
prevLevel5Type = None
for pos, e in enumerate(levelList):
    if pos == len(levelList) - 1: break
    currLevel = int(e.tag[-1])  # get last char - lt 10 levels in input
    nextLevelTag = levelList[pos+1].tag
    nextLevel = int(nextLevelTag[-1])
    #print ("%s c=%s, N=%s" % (e.tag, currLevel, nextLevel))
    if currLevel == 5 and nextLevel != 6:
        e.tag = renameTag['level6']  # no modulesubgroup
        prevLevel5Type = 'leaf'
    elif currLevel == 5 and nextLevel == 6:
        e.tag = renameTag['level5']
        prevLevel5Type = 'node'
    else:
        e.tag = renameTag[e.tag]
    indent = ('  ' * (currLevel - 2))
    prevLevel = int(levelStack[-1]) # get last element in list
    if currLevel == prevLevel:
        close_level(prevLevel, '', prevLevel5Type)
        new_level(e, indent)
    elif currLevel > prevLevel:
        levelStack.append(currLevel)
        print("")
        new_level(e, indent)
    elif currLevel < prevLevel:
        close_level(prevLevel, '', prevLevel5Type)
        levelStack.pop()
        for d in reversed(range(currLevel, prevLevel)):
            close_level(d, indent, prevLevel5Type)
        new_level(e, indent)

# print outstanding close tags
print("")
for i in reversed(levelStack):
    currLevel = i
    indent = ('  ' * (currLevel - 2))
    if i > 0:
        close_level(i, indent, prevLevel5Type)