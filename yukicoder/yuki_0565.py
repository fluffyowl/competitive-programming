R, K = map(int, raw_input().split())
H, W = map(int, raw_input().split())
B = [list(raw_input()) for _ in xrange(H)]


def rotate(A):
    h = len(A)
    w = len(A[0])
    C = [['' for _ in xrange(h)] for _ in xrange(w)]
    for i in xrange(h):
        for j in xrange(w):
            C[j][h-i-1] = A[i][j]
    return C


def scale(A, k):
    h = len(A)
    w = len(A[0])
    C = [['' for _ in xrange(w * k)] for _ in xrange(h * k)]
    for i in xrange(h):
        for j in xrange(w):
            for a in xrange(i*k, i*k+k):
                for b in xrange(j*k, j*k+k):
                    C[a][b] = A[i][j]
    return C


while R > 0:
    B = rotate(B)
    R -= 90

B = scale(B, K)

for i in xrange(len(B)):
    print ''.join(B[i])

