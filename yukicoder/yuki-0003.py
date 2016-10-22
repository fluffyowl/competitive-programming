import heapq

N = input()
def bitcount(i):
    i = i - ((i >> 1) & 0x55555555)
    i = (i & 0x33333333) + ((i >> 2) & 0x33333333)
    i = (i + (i >> 4)) & 0x0f0f0f0f
    i = i + (i >> 8)
    i = i + (i >> 16)
    return i & 0x3f

bc = [bitcount(i) for i in xrange(10001)]
rinsetsu = [[] for i in xrange(N+1)]
for i in xrange(1, N+1):
    m = i + bc[i]
    if m <= N:
        rinsetsu[i].append(m)
    m = i - bc[i]
    if m >= 1:
        rinsetsu[i].append(m)
        
def dijkstra(start):
    d = [float('inf') for i in xrange(N+1)]
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

d = dijkstra(1)[N] 
print -1 if d == float('inf') else d+1
