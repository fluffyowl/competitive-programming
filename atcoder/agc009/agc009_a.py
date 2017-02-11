N = input()
A = [0 for _ in xrange(N)]
B = [0 for _ in xrange(N)]
for i in xrange(N):
    a, b = map(int, raw_input().split())
    A[i] = a
    B[i] = b

ans = 0
for i in xrange(N-1, -1, -1):
    a, b = A[i]+ans, B[i]
    offset = (b - (a % b)) % b
    ans += offset
print ans
