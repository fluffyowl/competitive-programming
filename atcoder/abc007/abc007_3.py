import heapq

def manhattan(node, goal):
    return abs(node[0]-goal[0]) + abs(node[1]-goal[1])

def astar(nodes, edges, start, goal):
    openlist = []
    parent = {start:None}
    in_open = set()
    in_closed = set()
    f = {k:float('inf') for k in nodes}
 
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

        for next_node in edges[node]:
            gn = fval - manhattan(node, goal)
            fdm = gn + 1 + manhattan(next_node, goal)
            if next_node not in in_open and next_node not in in_closed:
                f[next_node] = fdm
                heapq.heappush(openlist, (fdm, next_node))
                in_open.add(next_node)
                parent[next_node] = node
            elif next_node in in_open:
                if fdm < f[next_node]:
                    f[next_node] = fdm
                    heapq.heappush(openlist, (fdm, next_node))
                    parent[next_node] = node
            elif next_node in in_closed:
                if fdm < f[next_node]:
                    f[next_node] = fdm
                    heapq.heappush(openlist, (fdm, next_node))
                    in_open.add(next_node)
                    in_closed.remove(next_node)
                    parent[next_node] = node
    return -1

def parse():
    R, C = map(int, raw_input().split())
    sy, sx = map(int, raw_input().split())
    gy, gx = map(int, raw_input().split())
    start = (sy-1, sx-1)
    goal = (gy-1, gx-1)

    graph = []
    for i in range(R):
        graph.append(list(raw_input()))

    edges = {}
    nodes = []

    for y in range(1, R-1):
        for x in range(1, C-1):
            e = []
            nodes.append((y,x))
            if graph[y-1][x] == '.':
                e.append((y-1, x))
            if graph[y+1][x] == '.':
                e.append((y+1, x))
            if graph[y][x-1] == '.':
                e.append((y, x-1))
            if graph[y][x+1] == '.':
                e.append((y, x+1))
            edges[(y, x)] = e
    return nodes, edges, start, goal

def run():
    nodes, edges, start, goal = parse()
    print astar(nodes, edges, start, goal)

if __name__ == '__main__':
    run()
