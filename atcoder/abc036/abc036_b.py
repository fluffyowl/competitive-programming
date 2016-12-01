N = int(raw_input())
a = [[0 for i in range(N)] for j in range(N)]

for i in range(N-1, -1, -1):
    b = list(raw_input())
    for j in range(N):
        a[j][i] = b[j]

for i in range(N):
    print ''.join(a[i])
