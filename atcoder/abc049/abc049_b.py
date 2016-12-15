H, W = map(int, raw_input().split())
C = [raw_input() for _ in xrange(H)]
A = [[C[i/2][j] for j in xrange(W)] for i in xrange(2*H)]
for a in A:
    print ''.join(a)
