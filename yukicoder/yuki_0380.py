import re
import fileinput
C = set(['digi', 'petit', 'rabi', 'gema', 'piyo'])


for i, line in enumerate(fileinput.input()):
    if i != 0:
        print ans
    a = line.rstrip('\n').split(' ', 1)
    ans = a
    if len(a) < 2:
        ans = 'WRONG!'
        continue
    name, line = a
    line = line.lower()
    if not name in C:
        ans = 'WRONG!'
    if name == 'digi' and re.search('nyo[\W_]{0,3}$', line):
        ans = 'CORRECT (maybe)'
    elif name == 'petit' and re.search('nyu[\W_]{0,3}$', line):
        ans = 'CORRECT (maybe)'
    elif name == 'rabi' and re.search('[A-Za-z0-9]', line):
        ans = 'CORRECT (maybe)'
    elif name == 'gema' and re.search('gema[\W_]{0,3}$', line):
        ans = 'CORRECT (maybe)'
    elif name == 'piyo' and re.search('pyo[\W_]{0,3}$', line):
        ans = 'CORRECT (maybe)'
    else:
        ans = 'WRONG!'
    
if line != '':
    print ans

