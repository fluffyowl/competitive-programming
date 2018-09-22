N, X = map(int, raw_input().split())
A = map(int, raw_input().split())
A.sort()
ans = 0

for i in xrange(N):
    if X >= A[i]:
        if i < N - 1 or X == A[i]:
            ans += 1
            X -= A[i]

print ans
