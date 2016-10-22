D = input()
s = raw_input()+raw_input()
o = map(len, filter(None, s.split('x')))
x = map(len, filter(None, s.split('o')))
if len(o) == 0:
    print D
    exit()
if s.startswith('x'):
    x.pop(0)
if s.endswith('x'):
    x.pop()
ans = max(o[0]+D, o[-1]+D)
for i in xrange(len(x)):
    if x[i] <= D:
        ans = max(ans, o[i]+x[i]+o[i+1])
    else:
        ans = max(ans, max(o[i], o[i+1])+D)
print ans

