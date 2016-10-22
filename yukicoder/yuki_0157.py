from collections import deque
k1 = set()
W, H = map(int, raw_input().split())
board = [raw_input() for _ in xrange(H)]
drdc = [(1, 0), (-1, 0), (0, -1), (0, 1)]

def bfs(starts, collect):
    q = deque()
    for s in starts:
        q.append((s[0], s[1], 0))
    visited = set()
    while len(q) > 0:
        r, c, depth = q.popleft()
        if (r, c) in visited:
            continue
        if (not collect) and depth > 0 and board[r][c] == '.':
            return depth
        visited.add((r, c))
        for dr, dc in drdc:
            nr, nc, nd = r+dr, c+dc, depth
            if nr < 0 or nr >= H or nc < 0 or nc >= W:
                continue
            if (nr, nc) in visited:
                continue
            if board[nr][nc] == '#':
                if collect:
                    continue
                else:
                    nd += 1
            q.append((nr, nc, nd))
    return visited

for i, j in [(x, y) for x in xrange(H) for y in xrange(W)]:
    if board[i][j] == '.':
        k1 = bfs([(i, j)], True)
        break
print bfs(list(k1), False)
