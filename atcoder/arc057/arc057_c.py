N = raw_input()
M = len(N)
N = int(N)
A = N * N
B = (N+1)*(N+1)


for i in xrange(M-1, -1, -1):
    k = 100**i
    C = (A-1) / k + 1
    D = (B-1) / k + 1
    if (C != D):
        print C
        exit()
