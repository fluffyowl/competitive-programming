N = input()
b = [int(raw_input()) for _ in xrange(N)]
upper = 10 ** 18 + 1
lower = 0
x = 0
for i in xrange(N):
    if i % 4 == 0:
        x += b[i]
        upper = min(upper, x)
    elif i % 4 == 1:
        x -= b[i]
        upper = min(upper, x)
    elif i % 4 == 2:
        x -= b[i]
        lower = max(lower, x)
    else:
        x += b[i]
        lower = max(lower, x)

if upper - lower <= 1:
    print -1
else:
    a = [0 for _ in xrange(N+1)]
    a[0] = lower + 1
    for i in xrange(1, N+1):
        a[i] = b[i-1] - a[i-1] if i % 2 == 1 else a[i-1] - b[i-1]
    print N+1
    for x in a:
        print x

