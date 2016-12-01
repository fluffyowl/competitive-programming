H, W, N = map(int, raw_input().split())
dx = [-1, 0, 1, -1, 0, 1, -1, 0, 1]
dy = [-1, -1, -1, 0, 0, 0, 1, 1, 1]
board = {}
 
for i in xrange(N):
    a, b = map(int, raw_input().split())
    for j in xrange(9):
        x, y = a+dx[j], b+dy[j]
        if x <= 1 or x >= H or y <= 1 or y >= W:
            continue
        if (x, y) in board:
            board[(x, y)] += 1
        else:
            board[(x, y)] = 1
ans = [0] * 10
for v in board.values():
    ans[v] += 1
ans[0] = (H-2)*(W-2)-sum(ans)
for a in ans:
    print a
