n = input()
A = sorted(map(int, raw_input().split()))
ans = 0
for i in xrange(n, 3*n, 2):
    ans += A[i]
print ans
