W, H = map(int, raw_input().split())
board = [map(int, raw_input().split()) for _ in xrange(H)]
visited = set()

dr = [0, 0, 1, -1]
dc = [1, -1, 0, 0]

def dfs(start):
    stack = [start]
    while len(stack) > 0:
        row, col = stack.pop()
        if (row, col) in visited:
            return True
        visited.add((row, col))
        for i in xrange(4):
            nrow = row+dr[i]
            ncol = col+dc[i]
            if nrow < 0 or nrow >= H or ncol < 0 or ncol >= W:
                continue
            if (nrow, ncol) in visited:
                continue
            if board[nrow][ncol] != board[row][col]:
                continue
            stack.append((nrow, ncol))
    return False

for i in xrange(H):
    for j in xrange(W):
        if (i, j) in visited:
            continue
        if dfs((i, j)):
            print 'possible'
            exit()
print 'impossible'

