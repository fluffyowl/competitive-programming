import heapq

N, M, T = map(int, raw_input().split())
A = map(int, raw_input().split())
rinsetsu = [[] for i in range(N)]
rinsetsu_inv = [[] for i in range(N)]
for i in range(M):
    a, b, c = map(int, raw_input().split())
    a, b = a-1, b-1
    rinsetsu[a].append((b, c))
    rinsetsu_inv[b].append((a,c))

def dijkstra(adj):
    dist = [float('inf') for i in xrange(N)]
    dist[0] = 0
    q = []

    for n, c in adj[0]:
        heapq.heappush(q, (c, n))
        dist[n] = c

    while len(q) != 0:
        c, n = heapq.heappop(q)
        if c > dist[n]:
            continue
        for nn, nc in adj[n]:
            alt = dist[n] + nc
            if dist[nn] > alt:
                dist[nn] = alt
                heapq.heappush(q, (alt, nn))

    return dist

d1 = dijkstra(rinsetsu)
d2 = dijkstra(rinsetsu_inv)
print max(filter(lambda x:x!=float('inf'), [A[n] * (T-d1[n]-d2[n]) for n in xrange(N)]))
