N = input()
T = map(int, raw_input().split())
A = map(int, raw_input().split())
MOD = 10**9+7

prev = -1
TP = [None for _ in xrange(N)]
for i, t in enumerate(T):
    if t > prev:
        TP[i] = (t, t)
    else:
        TP[i] = (1, t)
    prev = t

prev = -1
AP = [None for _ in xrange(N)]
for i in xrange(N-1, -1, -1):
    a = A[i]
    if a > prev:
        AP[i] = (a, a)
    else:
        AP[i] = (1, a)
    prev = a

ans = 1
for i in xrange(N):
    lt, rt = TP[i]
    la, ra = AP[i]

    if rt < la or ra < lt:
        print 0
        exit()

    s = sorted([lt, rt, la, ra])
    ans = ans * (s[2]-s[1]+1) % MOD
print ans
