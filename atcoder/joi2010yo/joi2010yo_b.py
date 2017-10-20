N, M = map(int, raw_input().split())
masu = [int(raw_input()) for _ in xrange(N)]
sai = [int(raw_input()) for _ in xrange(M)]
pos = 0

for i in xrange(M):
    pos += sai[i]
    if pos >= N - 1:
        print i + 1
        exit()
    pos += masu[pos]
    if pos >= N - 1:
        print i + 1
        exit()
