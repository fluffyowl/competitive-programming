p1x, p1y, p2x, p2y = map(int, raw_input().split())
N = int(raw_input())
xy = []
for i in xrange(N):
    xy.append(map(int, raw_input().split()))

cross = 0
for i in xrange(N):
    p3x, p3y = xy[i-1]
    p4x, p4y = xy[i]
    if ((p1x - p2x) * (p3y - p1y) + (p1y - p2y) * (p1x - p3x)) *\
       ((p1x - p2x) * (p4y - p1y) + (p1y - p2y) * (p1x - p4x)) < 0 and\
       ((p3x - p4x) * (p1y - p3y) + (p3y - p4y) * (p3x - p1x)) *\
       ((p3x - p4x) * (p2y - p3y) + (p3y - p4y) * (p3x - p2x)) < 0:
        cross += 1

print 1 + cross / 2
