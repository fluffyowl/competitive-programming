def f(n):
    r = 0
    while n:
        r, n = r + n % 10, n / 10
    return r

ans = []
N = input()
for y in xrange(170):
    x = N-y
    if x <= 0:
        break
    if x + f(x) == N:
        ans.append(x)

print len(ans)
for a in sorted(ans):
    print a
