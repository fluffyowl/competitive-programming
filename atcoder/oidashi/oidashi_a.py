import Queue

H, W = map(int, raw_input().split())
board = [['x']*(W+2)]
for i in xrange(H):
    board.append(['x'] + list(raw_input()) + ['x'])
    if 'S' in board[-1]:
        start = (i+1, board[-1].index('S'))
    if 'G' in board[-1]:
        goal = (i+1, board[-1].index('G'))
board.append(['x']*(W+2))

dxdy = [(0, 1), (0, -1), (1, 0), (-1, 0)]

def bfs(start):
    q = Queue.Queue()
    walls = {}
    q.put((start, 0))
    visited = set()
    
    while not q.empty():
        zahyo, depth = q.get()
        if zahyo in visited:
            continue
        visited.add(zahyo)
        x, y = zahyo
        if board[x][y] == 'x':
            continue
        if board[x][y] == '#':
            walls[zahyo] = depth
            continue

        for dx, dy in dxdy:
            nx, ny = x+dx, y+dy
            if (nx, ny) in visited:
                continue
            q.put(((nx, ny), depth+1))
    return walls

a = bfs(start)
b = bfs(goal)
ans = 0
for z in a:
    if z in b and a[z] + b[z] > ans:
        ans = a[z] + b[z]
print ans
