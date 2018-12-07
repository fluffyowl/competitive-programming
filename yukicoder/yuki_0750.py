from fractions import Fraction as F
N = input()
A = []
for i in xrange(N):
    a, b = map(int, raw_input().split())
    A.append((F(a, b), a, b))
A.sort()
for i in xrange(N-1, -1, -1):
    print A[i][1], A[i][2]

