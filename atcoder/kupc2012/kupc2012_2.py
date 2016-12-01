import re
c = raw_input()
c = re.sub('o+', 'o', c)
c = re.sub('x+', 'x', c)
print 'o' if len(c)%2 == 0 or c[0] == 'o' else 'x'
