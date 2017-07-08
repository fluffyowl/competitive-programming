from fractions import Fraction

b1, b2, b3 = map(int, raw_input().split())
if b1 == b2:
    print b1
else:
    r = Fraction(b2 - b3, b1 - b2)
    d = -r * b1 + b2
    print int(r * b3 + d)

