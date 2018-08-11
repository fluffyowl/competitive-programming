from fractions import Fraction

N, M, D = map(int, raw_input().split())
X = N - D
if D != 0:
    X *= 2
print "%.9f" % (1.0 * X * (M-1) / (N * N))
