from fractions import Fraction

a, b, c, d = map(int, raw_input().split())
N = input()

A = a / Fraction(1, 4)
B = b / Fraction(1, 2)
C = c / Fraction(1, 1)
D = d / Fraction(2, 1)
ans = 0

if D < A and D < B and D < C:
    ans += N / 2 * d
    ans += min(A, B, C) * (N % 2)
else:
    ans += min(A, B, C) * N

print int(ans)
