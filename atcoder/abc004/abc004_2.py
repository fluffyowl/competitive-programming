c = []
for i in range(4):
    c.append(raw_input().split())
for i in range(3, -1,-1):
    for j in range(3, -1, -1):
        print c[i][j],
    print
