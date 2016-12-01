H, W = map(int, raw_input().split())
B = [raw_input().split() for _ in xrange(H)]
for i in xrange(H):
    for j in xrange(W):
        if B[i][j] == 'snuke':
            print chr(ord('A')+j) + str(i+1)
            exit()
