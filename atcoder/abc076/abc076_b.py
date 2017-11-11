N = input()
K = input()
X = 1
for i in xrange(N):
    X = min(X*2, X+K)
print X
