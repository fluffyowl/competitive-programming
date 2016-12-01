import heapq
 
n, m = map(int, raw_input().split())
s, t = map(int, raw_input().split())
s, t = s-1, t-1
rinsetsu = [[] for i in range(n)]
costs = {}
for i in range(m):
    a, b, c = map(int, raw_input().split())
    a, b = a-1, b-1
    rinsetsu[a].append(b)
    rinsetsu[b].append(a)
    costs[(a, b)] = c
    costs[(b, a)] = c
 
def dijkstra(start):
    d = [float('inf') for i in range(n)]
    d[start] = 0
    q = []
    heapq.heappush(q, (0, start))
    while len(q) != 0:
        c, node = heapq.heappop(q)
        if c > d[node]:
            continue
        for nn in rinsetsu[node]:
            alt = d[node] + costs[(node, nn)]
            if alt < d[nn]:
                d[nn] = alt
                heapq.heappush(q, (alt, nn))
    return d
 
d1 = dijkstra(s)
d2 = dijkstra(t)
ans = [i for i in range(n) if d1[i]==d2[i] and d1[i] != float('inf')]
print ans[0]+1 if len(ans) else -1
