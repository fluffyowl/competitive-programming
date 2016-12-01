from Queue import Queue
import heapq

MOD = 10**9+7
N = int(raw_input())
a, b = map(int, raw_input().split())
a, b = a-1, b-1
M = int(raw_input())
rinsetsu = [[] for i in range(N)]
for i in range(M):
    x, y = map(int, raw_input().split())
    x, y = x-1, y-1
    rinsetsu[x].append(y)
    rinsetsu[y].append(x)

def dijkstra(start):
    d = [float('inf') for i in range(N)]
    d[start] = 0
    q = []
    heapq.heappush(q, (0, start))
    while len(q) != 0:
        c, node = heapq.heappop(q)
        if c > d[node]:
            continue
        for nn in rinsetsu[node]:
            alt = d[node] + 1
            if alt < d[nn]:
                d[nn] = alt
                heapq.heappush(q, (alt, nn))
    return d

d1 = dijkstra(a)
start_to_goal = d1[b]
ans = {i:0 for i in xrange(N)}
ans[a] += 1

q = Queue()
q.put(a)
visited = [False for _ in xrange(N)]
while not q.empty():
    node = q.get()
    if visited[node]:
        continue
    visited[node] = True
    for nn in rinsetsu[node]:
        if d1[nn] -d1[node] != 1:
            continue
        q.put(nn)
        ans[nn] = (ans[nn] + ans[node]) % MOD

print ans[b]
