import heapq

N, K = map(int, raw_input().split())
X = [(-e, i+1) for i, e in enumerate(map(int, raw_input().split()))]

q = []
for i in xrange(K):
    heapq.heappush(q, X[i])

for i in xrange(K, N):
    print q[0][1]
    heapq.heappush(q, X[i])
    heapq.heappop(q)
print q[0][1]
