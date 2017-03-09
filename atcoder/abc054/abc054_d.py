N, ma, mb = map(int, raw_input().split())
A = [map(int, raw_input().split()) for _ in xrange(N)]

if N == 1:
    if ma * A[0][0] == mb * A[0][1]:
        print A[0][2]
    else:
        print -1
    exit()

n = N / 2
m = N / 2 + N % 2

B = [[0, 0, 0] for _ in xrange(2**n)]

for i in xrange(2**n):
    for j in xrange(n):
        if i & (1 << j):
            B[i][0] += A[j][0]
            B[i][1] += A[j][1]
            B[i][2] += A[j][2]

d = {}
ans = float('inf')

for i in xrange(2**m):
    a = 0
    b = 0
    c = 0
    for j in xrange(m):
        if i & (1 << j):
            a += A[n+j][0]
            b += A[n+j][1]
            c += A[n+j][2]
    x = ma * b - mb * a
    if x == 0 and c > 0:
        ans = min(ans, c)
    if x in d:
        d[x] = min(d[x], c)
    else:
        d[x] = c

for a, b, c in B:
    x = mb * a - ma * b
    if x == 0 and c > 0:
        ans = min(ans, c)
    if x in d and c + d[x] > 0:
        ans = min(ans, c + d[x])
print ans if ans != float('inf') else -1
