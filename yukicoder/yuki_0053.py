from fractions import Fraction as F
f = lambda x,y:F(19, 4)*y-F(3*x)
ans = [0 for i in xrange(105)]
ans[0] = F(4)
ans[1] = F(3)
N = input()
for i in xrange(2, N+1):
    ans[i] = f(ans[i-2], ans[i-1])
print float(ans[N])

