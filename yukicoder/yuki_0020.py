import heapq

def manhattan(node, goal):
    return 0

def astar(n, graph, start, goal):
    dx = [0, 0, 1, -1]
    dy = [1, -1, 0, 0]
    openlist = []
    in_open = set()
    in_closed = set()
    f = {(i, j):float('inf') for i in xrange(n) for j in xrange(n)}
 
    f[start] = manhattan(start, goal)
    heapq.heappush(openlist, (f[start], start))
    in_open.add(start)

    while len(openlist) != 0:
        fval, node = heapq.heappop(openlist)
        if node not in in_open:
            continue
        elif fval != f[node]:
            continue
        
        if node == goal:
            return f[node]

        in_open.remove(node)
        in_closed.add(node)

        for next_node in [(node[0]+dx[i], node[1]+dy[i]) for i in xrange(4)]:
            if next_node[0] < 0 or next_node[0] >= n or next_node[1] < 0 or next_node[1] >= n:
                continue
            gn = fval - manhattan(node, goal)
            fdm = gn + graph[next_node[0]][next_node[1]] + manhattan(next_node, goal)
            if next_node not in in_open and next_node not in in_closed:
                f[next_node] = fdm
                heapq.heappush(openlist, (fdm, next_node))
                in_open.add(next_node)
            elif next_node in in_open:
                if fdm < f[next_node]:
                    f[next_node] = fdm
                    heapq.heappush(openlist, (fdm, next_node))
            elif next_node in in_closed:
                if fdm < f[next_node]:
                    f[next_node] = fdm
                    heapq.heappush(openlist, (fdm, next_node))
                    in_open.add(next_node)
                    in_closed.remove(next_node)
    return -1

def parse():
    N, V, Ox, Oy = map(int, raw_input().split())
    graph = [map(int, raw_input().split()) for _ in xrange(N)]
    return N, V, graph, (Oy-1, Ox-1)

def run():
    n, v, graph, oasis = parse()
    c1 = astar(n, graph, (0, 0), (n-1, n-1))
    if oasis == (-1, -1):
        print 'YES' if c1 < v else 'NO'
        return
    c2 = astar(n, graph, (0, 0), oasis)
    c3 = astar(n, graph, oasis, (n-1, n-1))
    #print c1, c2, c3
    print 'YES' if c1 < v or (c2 < v and c3 < (v-c2)*2) else 'NO'

if __name__ == '__main__':
    run()

