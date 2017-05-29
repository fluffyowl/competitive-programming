A = [0 for _ in xrange(10**5+10)]
N, K = map(int, raw_input().split())
for i in xrange(N):
    a, b = map(int, raw_input().split())
    A[a] += b

k = 0
for i in xrange(10**5+10):
    k += A[i]
    if k >= K:
        print i
        break
