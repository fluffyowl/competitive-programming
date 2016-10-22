from fractions import Fraction
N = input()
Z = map(int, raw_input().split())
theta = [0 for _ in xrange(N)]
theta[0] = Fraction(1)
for i in xrange(1, N):
    theta[i] = theta[i-1]*Z[i-1]/Z[i]
ans = theta[0]/theta[N-1]
print str(ans.numerator)+'/'+str(ans.denominator)

