import heapq

H, W, T = map(int, raw_input().split())
drdc = [(-1, 0), (1, 0), (0, -1), (0, 1)]
meiro = []
for i in range(H):
    meiro.append(list(raw_input()))
    if 'S' in meiro[-1]:
        start = (i, meiro[-1].index('S'))
    if 'G' in meiro[-1]:
        goal  = (i, meiro[-1].index('G'))

def dijkstra(start, x):
    d = dict(((i,j), float('inf')) for i in range(H) for j in range(W)) 
    d[start] = 0
    q = []
    heapq.heappush(q, (0, start))
    while len(q) != 0:
        c, node = heapq.heappop(q)
        if c > d[node]:
            continue
        for dr, dc in drdc:
            nn = (node[0]+dr, node[1]+dc)
            if nn[0] < 0 or nn[1] < 0 or nn[0] >= H or nn[1] >= W:
                continue
            ncost = x if meiro[nn[0]][nn[1]] == '#' else 1
            alt = d[node] + ncost
            if alt < d[nn]:
                d[nn] = alt
                heapq.heappush(q, (alt, nn))
    return d

minimum, maximum = 1, T-1
while maximum - minimum > 1:
    current = (minimum+maximum)/2
    d = dijkstra(start, current)
    if d[goal] > T:
        maximum = current
    else:
        minimum = current

print maximum if dijkstra(start, maximum)[goal] <= T else minimum
