from fractions import Fraction as F
A, B = map(int, raw_input().split())
print 50*A+int(F(50*A, F(4,5)+F(1,5)*B))

