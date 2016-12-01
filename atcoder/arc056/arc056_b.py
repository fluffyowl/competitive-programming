import heapq

N, M, S = map(int, raw_input().split())
rinsetsu = [[] for i in xrange(N+1)]
for i in xrange(M):
    u, v = map(int, raw_input().split())
    rinsetsu[u].append(v)
    rinsetsu[v].append(u)

reached = [0 for _ in xrange(N+1)]
q = []
heapq.heappush(q, (-S, S))
while len(q) > 0:
    max_n, node = heapq.heappop(q)
    max_n *= -1
    if max_n <= reached[node]:
        continue
    reached[node] = max_n
    for nn in rinsetsu[node]:
        heapq.heappush(q, (-min(max_n, nn), nn))

for i in xrange(1, N+1):
    if reached[i] >= i:
        print i
