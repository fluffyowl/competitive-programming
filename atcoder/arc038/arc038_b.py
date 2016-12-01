H, W = map(int, raw_input().split())
board = [raw_input()+'#' for i in xrange(H)]
board.append('#'*(W+1))
kachimake = [[None for i in xrange(W+1)] for i in xrange(H+1)]

for i in xrange(H-1, -1, -1):
    for j in xrange(W-1, -1, -1):
        if board[i][j] == '#':
            continue
        if (kachimake[i+1][j] is False) or (kachimake[i][j+1] is False) or (kachimake[i+1][j+1] is False):
            kachimake[i][j] = True
        else:
            kachimake[i][j] = False

print 'First' if kachimake[0][0] else 'Second'
