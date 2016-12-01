from fractions import Fraction
N, va, vb, L = map(int, raw_input().split())
print '%.10f' % float(Fraction(L, Fraction(va, vb)**N))
