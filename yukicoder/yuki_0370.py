N, M = map(int, raw_input().split())
D = [int(raw_input()) for _ in xrange(M)]
plus = sorted([d for d in D if d > 0])
minus = sorted([abs(d) for d in D if d < 0])
if 0 in D:
    N -= 1

if N == 0:
    print 0
    exit()
if len(plus) == 0:
    print minus[N-1]
    exit()
if len(minus) == 0:
    print plus[N-1]
    exit()

ans = float('inf')
for i in xrange(len(plus)+1):
    for j in xrange(len(minus)+1):
        if i+j == N:
            if i == 0:
                ans = min(ans, minus[j-1])
            elif j == 0:
                ans = min(ans, plus[i-1])
            else:
                a, b = sorted([plus[i-1], minus[j-1]])
                ans = min(ans, a*2+b)
print ans

