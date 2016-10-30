N, K = map(int, raw_input().split())

ans = 0
for b in xrange(1<<N):
    L1, L2 = [], []
    for i in xrange(N):
        if b & (1<<i):
            L1.append(i+1)
        else:
            L2.append(i+1)
    if len(L1) == 0 or len(L2) == 0:
        continue
    if L1[0] != K:
        continue
    if L1[-1] < L2[0]:
        continue
    ans += 1
print ans

