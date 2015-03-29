__author__ = 'r2h2'
# convert <vorleseungsverzeichnis> into proper hirarchcal structure
import xml.etree.ElementTree

eAbor = xml.etree.ElementTree.parse('vlz_kap_706 frag.xml').getroot()


level_stack = [0]
prev_level = 0

def close_level(l, indent):
    if indent:
        print('  ' * (curr_level - 2), end="")
    print("</level%s>" %l)

def new_level(e):
    print("%s<%s anchor=%s>" % ('  ' * (curr_level - 2), e.tag, e.attrib['anker']), end="")


for e in eAbor.findall('*'):
    if e.tag.startswith('level'):
        curr_level = int(e.tag[-1])  # get last char - max 6 levels in input
        prev_level = int(level_stack[-1]) # get last element in list
        if curr_level == prev_level:
            close_level(prev_level, False)
            new_level(e)
        elif curr_level > prev_level:
            level_stack.append(curr_level)
            print("")
            new_level(e)
        elif curr_level < prev_level:
            close_level(prev_level, False)
            level_stack.pop()
            for d in reversed(range(curr_level, prev_level)):
                close_level(d, True)
            new_level(e)

print("\n")
for i in reversed(level_stack):
    curr_level = i
    if i > 0:
        close_level(i, True)