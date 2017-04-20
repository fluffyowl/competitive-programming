N, D = map(int, raw_input().split())
zero = "C"
one = "A"
two = "B"

ans = ["" for _ in xrange(N)]
for i in xrange(N):
    M = N - i
    if D == 2 * M:
        ans[i] = two
        D -= 2
    elif D > 0:
        ans[i] = one
        D -= 1
    else:
        ans[i] = zero

print ''.join(ans)

