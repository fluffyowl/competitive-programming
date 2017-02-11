N, L = map(int, raw_input().split())
pos = float('-inf')
seg = []
s, g = None, None

for i in xrange(N):
    x = int(raw_input())
    if s is None:
        s, g = x, x
    elif x - g < L:
        g = x
    else:
        seg.append((s, g))
        s, g = x, x
seg.append((s, g))

pos = float('-inf')
for i, s in enumerate(seg):
    s, g = s
    if g - s >= L:
        print 'NO'
        exit()
    if i > 0 and s - pos <= 0:
        print 'NO'
        exit()

    if i == 0:
        pos = 0
    if g - pos >= L:
        pos = g+L
    else:
        pos = pos+L+L
print 'YES'
