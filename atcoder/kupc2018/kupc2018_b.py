from itertools import product

H, W = map(int, raw_input().split())
A = [raw_input() for _ in xrange(H)]
start = A[-1].index('s')

for p in product('LRS', repeat=H-1):
    s = start
    ok = True
    for i in xrange(H-1):
        if p[i] == 'L':
            s -= 1
        elif p[i] == 'R':
            s += 1
        if s < 0 or s >= W or A[-i-2][s] == 'x':
            ok = False
            break
    if ok:
        print ''.join(p)
        exit()

print 'impossible'
