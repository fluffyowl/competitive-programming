x, y, W = raw_input().split()
x, y = int(x)-1, int(y)-1
c = []
for i in range(9):
    c.append(list(raw_input()))
d = {'R': ( 0,  1),
     'L': ( 0, -1),
     'U': (-1,  0),
     'D': ( 1,  0),
     'RU':(-1,  1),
     'RD':( 1,  1),
     'LU':(-1, -1),
     'LD':( 1, -1)}

direction = d[W]
ans = [(y, x)]
for i in range(3):
    cx, cy = ans[-1]
    dx, dy = direction
    if cx + dx >= 9:
        dx = -1
    if cx + dx < 0:
        dx = 1
    if cy + dy >= 9:
        dy = -1
    if cy + dy < 0:
        dy = 1
    direction = (dx, dy)
    ans.append((cx+dx, cy+dy))
print ''.join([str(c[a[0]][a[1]]) for a in ans])
