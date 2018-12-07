from fractions import Fraction as F
N = input()
A = map(int, raw_input().split())
M = input()
B = map(int, raw_input().split())
B.reverse()
X = F(A[0])
for i in xrange(1, N):
    X /= F(A[i])
Y = F(B[0])
for i in xrange(1, M):
    Y = F(B[i]) / Y
Z = X / Y
if Z < 0:
    Z = abs(Z)
    print -Z.numerator, Z.denominator
else:
    print Z.numerator, Z.denominator

