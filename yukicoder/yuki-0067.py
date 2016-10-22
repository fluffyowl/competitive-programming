N = int(raw_input())
L = map(int, raw_input().split())
K = int(raw_input())
EPS = 10**(-9)

high = float(max(L))
low = 0.0
for i in xrange(50):
    middle = (high+low)/2.0
    if sum(int(x/middle) for x in L) >= K:
        low = middle
    else:
        high = middle
print '%.09f'%high

