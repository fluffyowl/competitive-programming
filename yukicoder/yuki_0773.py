A, B = map(int, raw_input().split())

X = [0 for _ in xrange(40)]
X[23] = 1
X[24] = 1
X[25] = 1

for i in xrange(A, B+1):
    X[i] = 0

print sum(X)

