from fractions import Fraction
p, q = map(Fraction, raw_input().split())
print 'YES' if p*(1-q)*q > (1-p)*q else 'NO'

