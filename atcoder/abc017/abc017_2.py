s = raw_input()
CHOKU = ['ch', 'o', 'k', 'u']
for p in CHOKU:
    s = s.replace(p, '')
if len(s) == 0:
    print 'YES'
else:
    print 'NO'
