S = map(int, raw_input().split())
p = [S[i*2:i*2+2] for i in xrange(3)]
d = lambda p1, p2: (p1[0]-p2[0])**2+(p1[1]-p2[1])**2

for i in xrange(3):
    b1 = [p[i][0]-p[i-1][0], p[i][1]-p[i-1][1]]
    b2 = [p[i][0]-p[i-2][0], p[i][1]-p[i-2][1]]
    if d(p[i], p[i-1]) == d(p[i], p[i-2]) and b1[0]*b2[0]+b2[1]*b1[1] == 0:
        print p[i-1][0] - b2[0], p[i-1][1] - b2[1]
        exit()
print -1

