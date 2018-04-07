X, K = raw_input().split()
X = list(X)
K = int(K)

if K >= len(X):
    print '1' + '0'*K
    exit()

for i in xrange(K):
    X[-i-1] = '0'

X = int(''.join(X))

X += 10 ** K

print X
