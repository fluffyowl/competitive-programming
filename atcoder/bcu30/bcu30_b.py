N = 9
B = [list(raw_input()) for _ in xrange(N)]

for i in xrange(9):
    s = set(B[i])
    if len(s) != N:
        print 'No'
        exit()

for i in xrange(9):
    s = set([B[j][i] for j in xrange(N)])
    if len(s) != N:
        print 'No'
        exit()


dr = [-1, -2, -2, -1, 1, 2,  2,  1]
dc = [-2, -1,  1,  2, 2, 1, -1, -2]
        
for i in xrange(9):
    for j in xrange(9):
        for k in xrange(8):
            r = i + dr[k]
            c = j + dc[k]
            if r >= 0 and r < N and c >= 0 and c < N and B[i][j] == B[r][c]:
                print 'No'
                exit()

print 'Yes'
