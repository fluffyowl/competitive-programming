N, M = map(int, raw_input().split())
A = map(int, raw_input().split())

cnt = 0
tmp = 0
for i in xrange(N):
    if A[i] % 2 == 1:
        cnt += 1
        tmp += A[i]
    else:
        if cnt >= M:
            print tmp
        cnt = 0
        tmp = 0

if cnt >= M:
    print tmp
