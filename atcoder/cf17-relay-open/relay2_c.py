N, K = map(int, raw_input().split())
W = [i for i in xrange(N)]
D = [i for i in xrange(N)]
for i in xrange(N):
    W[i], D[i] = map(int, raw_input().split())

hi = 10**20
lo = 0

while hi - lo > 1:
    mid = (hi + lo) / 2
    cnt = 0
    for i in xrange(N):
        if mid >= W[i]:
            cnt += (mid-W[i])/D[i]+1
    if cnt >= K:
        hi = mid
    else:
        lo = mid
print hi N, K = map(int, raw_input().split())
W = [i for i in xrange(N)]
D = [i for i in xrange(N)]
for i in xrange(N):
    W[i], D[i] = map(int, raw_input().split())

hi = 10**20
lo = 0

while hi - lo > 1:
    mid = (hi + lo) / 2
    cnt = 0
    for i in xrange(N):
        if mid >= W[i]:
            cnt += (mid-W[i])/D[i]+1
    if cnt >= K:
        hi = mid
    else:
        lo = mid
print hi
