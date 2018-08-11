from fractions import Fraction

C = map(int, raw_input().split())
X = C[0] * C[2] - C[1] * C[1]
Y = C[0] * C[3] - C[1] * C[2]
Z = C[1] * C[3] - C[2] * C[2]

print "R" if Fraction(Y, X) ** 2 - 4 * Fraction(Z, X) >= 0 else "I"

