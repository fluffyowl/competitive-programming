import heapq

N, M, S, G = map(int, raw_input().split())
rinsetsu = [[] for i in xrange(N)]
for _ in xrange(M):
    a, b, c = map(int, raw_input().split())
    rinsetsu[a].append((b, c))
    rinsetsu[b].append((a, c))

def dijkstra():
    dist = [(float('inf'), []) for i in xrange(N)]
    dist[S] = (0, [S])
    q = []

    for n, c in rinsetsu[S]:
        heapq.heappush(q, (c, n))
        dist[n] = (c, [S, n])

    while len(q) != 0:
        c, n = heapq.heappop(q)
        if c > dist[n][0]:
            continue
        for nn, nc in rinsetsu[n]:
            alt = dist[n][0] + nc
            if dist[nn][0] > alt or (dist[nn][0] == alt and dist[n][1]+[nn] < dist[nn][1]):
                dist[nn] = (alt, dist[n][1]+[nn])
                heapq.heappush(q, (alt, nn))
                
    return dist

print ' '.join(map(str, dijkstra()[G][1]))

