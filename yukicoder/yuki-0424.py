H, W = map(int, raw_input().split())
sx, sy, gx, gy = map(int, raw_input().split())
goal = (gx-1, gy-1)
board = [map(int, list(raw_input())) for _ in xrange(H)]

dh = [1, -1, 0, 0]
dw = [0, 0, 1, -1]
stack = [(sx-1, sy-1)]
visited = set()
while len(stack) > 0:
    node = stack.pop()
    if node == goal:
        print 'YES'
        exit()
    if node in visited:
        continue
    visited.add(node)
    for i in xrange(4):
        nh, nw = node[0]+dh[i], node[1]+dw[i]
        if nh < 0 or nh >= H or nw < 0 or nw >= W:
            continue
        if (nh, nw) in visited:
            continue
        if abs(board[nh][nw] - board[node[0]][node[1]]) > 1:
            continue
        stack.append((nh, nw))
    for i in xrange(4):
        nh, nw = node[0]+dh[i]*2, node[1]+dw[i]*2
        if nh < 0 or nh >= H or nw < 0 or nw >= W:
            continue
        if (nh, nw) in visited:
            continue
        a, b, c = board[node[0]][node[1]], board[nh][nw], board[node[0]+dh[i]][node[1]+dw[i]]
        if a != b or c >= a or c >= b:
            continue
        stack.append((nh, nw))
print 'NO'

