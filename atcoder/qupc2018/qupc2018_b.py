Q = input()

def solve():
    A, B, C = map(int, raw_input().split())
    X = A * 100 + B * 10 + C
    if X % 2 == 1:
        return False
    Y = X / 2
    if Y % 10 > C:
        return False
    C -= Y % 10
    Y -= Y % 10
    if Y % 100 > B * 10 + C:
        return False
    BC = B * 10 + C - Y % 100
    Y -= Y % 100
    if Y > A * 100 + BC:
        return False
    return True

for _ in xrange(Q):
    print "Yes" if solve() else "No"
