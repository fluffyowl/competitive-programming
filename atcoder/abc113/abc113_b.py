from fractions import Fraction

N = input()
T, A = map(int, raw_input().split())
H = map(int, raw_input().split())

v = float('inf')
x = -1

for i in xrange(N):
    vv = T - H[i] * Fraction(6, 1000)
    vvv = abs(A - vv)
    if vvv < v:
        v = vvv
        x = i

print x + 1
