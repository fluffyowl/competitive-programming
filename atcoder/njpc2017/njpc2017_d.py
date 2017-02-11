N, M, K = map(int, raw_input().split())
B = [[i*M+j+1 for j in xrange(M)] for i in xrange(N)]


def ans():
    for b in B:
        print ' '.join(map(str, b))
    exit()

for i in xrange(N):
    if K == 0:
        ans()
    if M == 1:
        break
    if K >= M*(M-1)/2:
        B[i] = B[i][::-1]
        K -= M*(M-1)/2
    elif K > 0:
        for j in xrange(M):
            for k in xrange(M-j-1):
                B[i][k], B[i][k+1] = B[i][k+1], B[i][k]
                K -= 1
                if K == 0:
                    ans()

if K == 0:
    ans()

f = False
for i in xrange(N):
    if f:
        break
    for j in xrange(N-i-1):
        B[j], B[j+1] = B[j+1], B[j]
        K -= M
        if K <= 0:
            f = True
            break
if K == 0:
    ans()

for i in xrange(M):
    for j in xrange(M-i-1):
        B[0][j], B[0][j+1] = B[0][j+1], B[0][j]
        K += 1
        if K == 0:
            ans()
ans()
