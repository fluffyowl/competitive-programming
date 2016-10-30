from collections import Counter
N = input()
A = map(int, raw_input().split())
C = Counter(A)
M = len(C.keys())
K = C.keys()
MOD = 10**9+7

ans = 0
for i in xrange(M):
    for j in xrange(i+1, M):
        for k in xrange(j+1, M):
            ans = (ans + C[K[i]]*C[K[j]]*C[K[k]]) % MOD
print ans

