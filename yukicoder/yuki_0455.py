H, W = map(int, raw_input().split())
B = [raw_input() for _ in xrange(H)]

s = []
for i in xrange(H):
    for j in xrange(W):
        if B[i][j] == '*':
            s.append((i, j))

flag = False
for i in xrange(H):
    for j in xrange(W):
        if (B[i][j] != '*'):
            v1 = (s[0][0]-i, s[0][1]-j)
            v2 = (s[1][0]-i, s[1][1]-j)
            if (v1[0]*v2[1] != v1[1]*v2[0]):
                x, y = i, j
                flag = True
                break
    if flag:
        break

for i in xrange(H):
    s = ''
    for j in xrange(W):
        if B[i][j] == '*' or (i == x and j == y):
            s += '*'
        else:
            s += '-'
    print s

