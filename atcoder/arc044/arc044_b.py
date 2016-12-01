from collections import Counter
 
MOD = 10**9+7
N = input()
A = map(int, raw_input().split())
C = Counter(A)
M = max(C.keys())
if A[0] != 0 or M >= N or C[0] > 1:
    print 0
    exit()
 
ans = 1
for i in xrange(1, M):
    if C[i] == 0:
        print 0
        exit()
    ans = ans * pow(2, C[i]*(C[i]-1)/2, MOD) % MOD
    for j in xrange(C[i+1]):
        ans = ans * ((pow(2, C[i], MOD)-1) % MOD) % MOD
print ans * pow(2, C[M]*(C[M]-1)/2, MOD) % MOD
