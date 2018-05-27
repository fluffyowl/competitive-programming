from fractions import Fraction


def is_kadomatsu(a, b, c):
    return b < a < c or b < c < a or b > a > c or b > c > a


def solve():
    x1, x2, x3, y1, y2, y3 = map(int, raw_input().split())

    if is_kadomatsu(x1, x2, x3):
        return "YES"

    T = []

    if y1 != y2:
        T.append(Fraction(x1-x2, y2-y1))
    if y2 != y3:
        T.append(Fraction(x2-x3, y3-y2))
    if y3 != y1:
        T.append(Fraction(x3-x1, y1-y3))

    d = Fraction(1, 10**18)

    for t in T:
        if t < 0:
            continue
        for sign in (1, -1):
            if t == 0 and sign == -1:
                continue
            a1 = x1 + y1 * (t + sign * d)
            a2 = x2 + y2 * (t + sign * d)
            a3 = x3 + y3 * (t + sign * d)
            if is_kadomatsu(a1, a2, a3):
                return "YES"

    return "NO"


Q = input()
for _ in xrange(Q):
    print solve()

