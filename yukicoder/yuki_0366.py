N, K = map(int, raw_input().split())
A = map(int, raw_input().split())
D = dict(zip(A, range(N)))
B = sorted(A)

ans = 0
for i, n in enumerate(B):
    j = D[n]
    if (j-i)%K != 0:
        print -1
        exit()
    ans += (j-i)/K
    for m in xrange(j, i+K-1, -K):
        D[A[m]], D[A[m-K]] = D[A[m-K]], D[A[m]]
        A[m], A[m-K] = A[m-K], A[m]
print ans

