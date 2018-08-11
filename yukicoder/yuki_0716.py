N = input()
A = sorted(map(int, raw_input().split()))
ans = float('inf')
for i in xrange(N-1):
    ans = min(ans, A[i+1] - A[i])
print ans
print A[-1] - A[0]
