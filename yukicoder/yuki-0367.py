from collections import deque

H, W = map(int, raw_input().split())
board = [raw_input() for _ in xrange(H)]
for i in xrange(H):
    if 'S' in board[i]:
        start = (i, board[i].index('S'))
    if 'G' in board[i]:
        goal = (i, board[i].index('G'))
move = {'K':[(-2, -1), (-2, 1), (2, -1), (2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2)],
        'B':[(-1, -1), (-1, 1), (1, -1), (1, 1)]}
tsugi = {'K':'B', 'B':'K'}

q = deque()
q.append((start[0], start[1], 'K', 0))
visited = set()
while len(q) > 0:
    r, c, koma, depth = q.popleft()
    if (r, c, koma) in visited:
        continue
    if (r, c) == goal:
        print depth
        exit()
    visited.add((r, c, koma))
    for dr, dc in move[koma]:
        nr, nc = r+dr, c+dc
        if nr < 0 or nr >= H or nc < 0 or nc >= W:
            continue
        nkoma = tsugi[koma] if board[nr][nc] == 'R' else koma
        if (nr, nc, nkoma) in visited:
            continue
        q.append((nr, nc, nkoma, depth+1))
print -1

