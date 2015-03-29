__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure
import xml.etree.ElementTree

eAbor = xml.etree.ElementTree.parse('vlz_kap_706 frag.xml').getroot()


level_stack = [0]
prev_level = 0

def close_level(l, indent):
    print("%s</level%s>" % (indent, l))

def new_level(e, indent=''):
    #print("%s<%s anchor=%s>" % (indent, e.tag, e.attrib['anker']), end="")
    print("%s<%s>" % (indent, e.tag), end="")
    anchor = e.attrib['anker'][1:]
    xpath = ('.//*[@id="%s"]' % anchor)
    #print(xpath, end="")
    chap = eAbor.find(xpath)
    if chap:
        print("\n  %s<%s" % (indent, chap.tag), end="")
        for k, v in chap.attrib.items():
            print(' %s="%s"' %(k, v), end="")
        print("/>", end="")


for e in eAbor.findall('*'):
    if e.tag.startswith('level'):
        curr_level = int(e.tag[-1])  # get last char - max 6 levels in input
        indent = ('  ' * (curr_level - 2))
        prev_level = int(level_stack[-1]) # get last element in list
        if curr_level == prev_level:
            close_level(prev_level, '')
            new_level(e, indent)
        elif curr_level > prev_level:
            level_stack.append(curr_level)
            print("")
            new_level(e, indent)
        elif curr_level < prev_level:
            close_level(prev_level, '')
            level_stack.pop()
            for d in reversed(range(curr_level, prev_level)):
                close_level(d, indent)
            new_level(e, indent)

# print outstanding close tags
for i in reversed(level_stack):
    curr_level = i
    indent = ('  ' * (curr_level - 2))
    if i > 0:
        close_level(i, indent)