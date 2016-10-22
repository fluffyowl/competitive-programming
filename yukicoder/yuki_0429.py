N, K, X = map(int, raw_input().split())
swap = []
for _ in xrange(K):
    r = raw_input().split()
    if r[0] == ('?'):
        continue
    swap.append(map(lambda x:int(x)-1, r))
C = map(int, raw_input().split())

A = [i for i in xrange(1, N+1)]
for i in xrange(X-1):
    A[swap[i][0]], A[swap[i][1]] = A[swap[i][1]], A[swap[i][0]]

for i in xrange(K-2, X-2, -1):
    C[swap[i][0]], C[swap[i][1]] = C[swap[i][1]], C[swap[i][0]]


ans = []
for i in xrange(N):
    if A[i] != C[i]:
        ans.append(i)
print ans[0]+1, ans[1]+1

