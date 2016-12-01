from fractions import Fraction

H, W, N = map(int, raw_input().split())
if N%2 == 1:
    print -1
    exit()

st = [map(int, raw_input().split()) for i in xrange(N)]

def hantei(X, Y):
    katamuki = Fraction(Y, X)
    b = [0, 0]
    for x, y in st:
        if y == katamuki * x:
            return False
        b[y > katamuki * x] += 1
    return b[0] == b[1]

ans = []
for i in xrange(1, H+1):
    if hantei(W, i):
        ans.append((W, i))
for i in xrange(1, W):
    if hantei(i, H):
        ans.append((i, H))

if len(ans) == 0:
    print -1
    exit()
for x, y in sorted(ans):
    print '('+str(x)+','+str(y)+')'
