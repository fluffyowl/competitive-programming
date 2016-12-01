a = []
for i in range(4):
    a.append(map(int, raw_input().split()))
for i in range(4):
    for j in range(3):
        if a[i][j] == a[i][j+1]:
            print 'CONTINUE'
            exit()
        if a[j][i] == a[j+1][i]:
            print 'CONTINUE'
            exit()
print 'GAMEOVER'
