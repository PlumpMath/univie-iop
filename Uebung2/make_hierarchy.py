__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure

from xml.etree import ElementTree
from xml.dom import minidom
from datetime import datetime
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

def new_hierarchy_element(e):
    newElem = ElementTree.Element(e.tag)
    parentElement = currentElem[-1]
    try:
        parentElement.append(newElem)  # append to document tree
    except IndexError:
        print("hallo?")
    currentElem.append(newElem)        # append to level stack
    add_attr_and_children(newElem, e)

def add_attr_and_children(newElem, e):
    anchor = e.attrib['anker'][1:]
    if anchor:
        newElem.set('id', anchor)
    newElem.set('name', e.attrib.get('name', '?'))
    if e.tag == 'module':
        add_course(newElem, e, anchor)
    #lstk = ''.join(str(levelStack))
    #print("%03d %d/%d/%d-{%d/%d} %s    | %s %s %s %s" % (pos, prevLevel,currLevel,nextLevel, len(currentElem), len(levelStack), lstk, "  " * (len(levelStack)-2), e.tag, anchor, e.attrib.get('name', '?')) )

def add_course(newElem, e, anchor):
    xpath = ('.//*[@id="%s"]/vlvz' % anchor)
    vlvz = inRoot.findall(xpath)
    for i, v in enumerate(vlvz):
        ElementTree.SubElement(newElem, 'course')
        course = newElem[i]
        lvnr = v.attrib.get('lvnr', '?')
        course.set('id', lvnr)
        course.set('type', v.attrib.get('typ', '?'))
        course.set('ects', re.sub('\\s', '', v.attrib.get('ects', '?').replace(',', '.')))
        course.set('hoursPerWeek', v.attrib.get('wochenstunden', '?'))
        xYN = {'N':'No', 'Y':'Yes', '?':''}
        course.set('continousassessment', xYN[v.attrib.get('pruefungsimmanent', '?')])
        course.set('title', v.attrib.get('kurztitel', '?'))
        add_group(anchor, course, lvnr)

def add_group(anchor, course, lvnr):
        # the same course ma appear under different <chaptera> - us anchor to uniquify
        xpath = './/*[@id="%s"]/vlvz[@lvnr="%s"]/gruppen' % (anchor, lvnr)
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
            add_languages(group[0], anchor, lvnr, group_id)
            ElementTree.SubElement(group, 'appointments')
            add_appointments(group[1], anchor, lvnr, group_id)
            ElementTree.SubElement(group, 'lecturers')
            add_lecturers(group[2], anchor, lvnr, group_id)

def add_languages(parent, anchor, lvnr, group_id):
        xpath = './/*[@id="%s"]/vlvz[@lvnr="%s"]/gruppen[@gruppe="%s"]/unterrichtssprachen' % (anchor, lvnr, group_id)
        sprachen = inRoot.findall(xpath)
        for i, s in enumerate(sprachen):
            ElementTree.SubElement(parent, 'lang')
            lang = parent[i]
            lang.text = s.text

def add_appointments(parent, anchor, lvnr, group_id):
        xpath = './/*[@id="%s"]/vlvz[@lvnr="%s"]/gruppen[@gruppe="%s"]/von_bis' % (anchor, lvnr, group_id)
        von_bis = inRoot.findall(xpath)
        for i, vb in enumerate(von_bis):
            ElementTree.SubElement(parent, 'appointment')
            apptmnt = parent[i]
            startdate = vb.attrib.get('datum', '?')[:11]
            starttime = vb.attrib.get('beginn', '?')
            startDatetime = datetime.strptime(startdate + ' ' + starttime, '%d-%b-%Y %H%M')
            apptmnt.set('start', startDatetime.strftime('%Y-%m-%dT%H:%M'))
            endtime = vb.attrib.get('ende', '?')
            endDatetime = datetime.strptime(startdate + ' ' + endtime, '%d-%b-%Y %H%M')
            apptmnt.set('end', endDatetime.strftime('%Y-%m-%dT%H:%M'))
            apptmnt.set('room', vb.attrib.get('kurzraumname', '?'))
            apptmnt.set('location', vb.attrib.get('ort', '?'))
            apptmnt.set('zip', vb.attrib.get('plz', '?'))
            apptmnt.set('street', vb.attrib.get('strasse', '?'))

def add_lecturers(parent, anchor, lvnr, group_id):
        xpath = './/*[@id="%s"]/vlvz[@lvnr="%s"]/gruppen[@gruppe="%s"]/vortragende' % (anchor, lvnr, group_id)
        vortragende = inRoot.findall(xpath)
        for i, vt in enumerate(vortragende):
            ElementTree.SubElement(parent, 'lecturer')
            lect = parent[i]
            lect.set('givenname', vt.attrib.get('vorname', '?'))
            lect.set('surname', vt.attrib.get('zuname', '?'))
            lect.set('role', vt.attrib.get('rolle_person', '?'))


# --- --- --- --- ---
#inRoot = ElementTree.parse('vlz_kap_706.xml').getroot()
with open ("vlz_kap_706.xml", "r") as xmlFile:
    xmlString=xmlFile.read()
# fix invalid char entities:
xmlString.replace(r'&amp;apos;', r'&apos;')
xmlString.replace(r'&amp;gt;', r'&gt;')
xmlString.replace(r'&amp;lt;', r'&lt;')
xmlString.replace(r'&amp;quot;', r'&quot;')
inRoot = ElementTree.fromstring(xmlString)
levelList = []

for e in inRoot.findall('*'):
    if e.tag.startswith('level'):
        levelList.append(e)
levelList.append(ElementTree.Element('level0')) # terminating element
    
# create hierarchy from linear list by inserting close tags at the appropriate location
outRoot = ElementTree.Element('lectureindex')
currentElem = [outRoot] # stack contains currrent level and ancestors
levelStack = [0] # level numbers
prevLevel = 0
pos = None
currLevel = None
nextLevel = None
prevLevel = None
for pos, e in enumerate(levelList):
    if pos == len(levelList) - 1: break
    prevLevel = int(levelStack[-1])
    currLevel = int(e.tag[-1])  # get last char - lt 10 levels in input
    nextLevel = int(levelList[pos+1].tag[-1])
    rename_element(e, currLevel, nextLevel)
    if currLevel == prevLevel:
        currentElem.pop()
        new_hierarchy_element(e)
    elif currLevel > prevLevel:
        levelStack.append(currLevel)
        new_hierarchy_element(e)
    elif currLevel < prevLevel:
        currentElem.pop()
        for d in reversed(range(currLevel, prevLevel)): # closing more than 1 level?
            #print("    closing level %d" % d)
            currentElem.pop()
            levelStack.pop()
        new_hierarchy_element(e)

outTree = ElementTree.ElementTree(outRoot)
outTree.write('vlz_kap_706_clean.xml', encoding='utf-8')
#print(prettifyXML(outRoot), file='z.xml')
