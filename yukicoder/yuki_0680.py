N = input()
hi = 10**10
lo = 0

if N == 0:
    print "YES"
    exit()

def f(n):
    a = 0
    while n > 0:
        a += n
        n /= 2
    return a

while hi - lo > 1:
    mid = (hi + lo) / 2
    if f(mid) >= N:
        hi = mid
    else:
        lo = mid

print "YES" if f(hi) == N else "NO"

