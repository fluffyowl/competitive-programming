from fractions import Fraction

X, Y = map(int, raw_input().split())
N = input()
A = map(int, raw_input().split())
Z = [Fraction(A[i], Y) for i in xrange(N)]

for i in xrange(N-1):
    t = Fraction(A[i], X)
    if t > Z[i+1]:
        print 'NO'
        exit()
print 'YES'

