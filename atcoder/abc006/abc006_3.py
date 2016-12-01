N, M = map(int, raw_input().split())
if M < 2*N or 4*N < M:
    print -1,-1,-1
    exit()
x = 0
MN = M - 2*N
for z in range(MN/2 + 2):
    y = MN - 2*z
    x = N - y - z
    if x>=0 and y>=0 and x+y+z==N and 2*x+3*y+4*z==M:
        print x, y, z
        exit()
print -1,-1,-1
