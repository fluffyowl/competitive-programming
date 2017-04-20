N = input()
A = map(int, raw_input().split())
d = 0
ans = 0
for i in xrange(N-1):
    dd = A[i+1] - A[i]
    if dd * d < 0:
        ans += 1
        d = 0
    else:
        if abs(dd) > 0:
            d = dd
print ans + 1
