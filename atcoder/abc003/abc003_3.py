from fractions import Fraction

N, K = map(int, raw_input().split())
R = map(int, raw_input().split())
C = Fraction(0, 1)

R = [r for r in sorted(R)]
if len(R) > K:
    R = R[-K:]

for r in R:
    if r > C:
        C = (C + r)  / 2
print float(C)
