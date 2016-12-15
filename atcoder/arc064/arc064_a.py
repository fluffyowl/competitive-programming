N, x = map(int, raw_input().split())
A = map(int, raw_input().split())

ans = 0
for i in xrange(N):
    if A[i] > x:
        ans += A[i] - x
        A[i] = x

for i in xrange(N-1):
    if A[i] + A[i+1] > x:
        ans += A[i] + A[i+1] - x
        A[i+1] -= A[i] + A[i+1] - x
    #print A, ans

print ans
