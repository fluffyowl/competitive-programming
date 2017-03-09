n, k = map(int, raw_input().split())
A = sorted(map(int, raw_input().split()))

p = 0
ans = 0
for i in xrange(k-1, -1, -1):
    ans += A[i] + p
    p += 1
print ans
