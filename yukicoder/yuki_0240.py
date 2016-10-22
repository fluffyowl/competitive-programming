dx = [-2, -2, -1, -1,  1, 1,  2, 2]
dy = [-1,  1, -2,  2, -2, 2, -1, 1]
visited = set()
stack = [(0, 0, 0)]
while len(stack) > 0:
    x, y, d = stack.pop()
    visited.add((x, y))
    if d == 3:
        continue
    for i in xrange(8):
        nx, ny = x+dx[i], y+dy[i]
        stack.append(((nx, ny, d+1)))
print 'YES' if tuple(map(int, raw_input().split())) in visited else 'NO'

