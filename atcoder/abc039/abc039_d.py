H, W = map(int, raw_input().split())
S = [['#'] * (W+2)]

for i in range(H):
    S.append(['#'] + list(raw_input()) + ['#'])
S.append(['#'] * (W+2))

for i in range(1, H+1):
    for j in range(1, W+1):
        if S[i][j] == '.':
            continue
        c = 0
        for x in [-1, 0, 1]:
            for y in [-1, 0, 1]:
                if S[i+x][j+y] == '#' or S[i+x][j+y] == '$':
                    c += 1
        if c == 9:
            S[i][j] = '$'

for i in range(1, H+1):
    for j in range(1, W+1):
        if S[i][j] != '#':
            continue
        c = 0
        for y in [-1, 0, 1]:
            for x in [-1, 0, 1]:
                if S[i+x][j+y] == '$':
                    c += 1
        if c == 0:
            print 'impossible'
            exit()

print 'possible'
for i in range(1, H+1):
    print ''.join(S[i][1:-1]).replace('#', '.').replace('$', '#')
