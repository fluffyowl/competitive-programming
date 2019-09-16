T, B = map(int, raw_input().split())
B *= -1

def solve():
    N = int(raw_input())

    if N == 0:
        print 0
        return

    ans = []
    t = 0
    while N != 0:
        m = N % B
        if t == 0 or m == 0:
            ans.append(m)
            N /= B
        else:
            ans.append(B - m)
            N += B - m
            N /= B
        t ^= 1
    print "".join(map(str, reversed(ans)))


for _ in xrange(T):
    solve()

