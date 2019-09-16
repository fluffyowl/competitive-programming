from fractions import Fraction as f

P, Q = map(f, raw_input().split())

A = f(P, 100) * f(Q, 100)
B = A + f(100-P, 100) * f(100-Q,100)

print "%.10f" % (A / B * 100)

