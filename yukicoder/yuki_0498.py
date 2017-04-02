import itertools

Gx, Gy, K = map(int, raw_input().split())
C = [[] for _ in xrange(K)]
for i in xrange(K):
    x, y, n = map(int, raw_input().split())
    for j in xrange(n+1):
        C[i].append((x*j, y*j, j))

F = [1 for _ in xrange(76)]
for i in xrange(1, 76):
    F[i] = F[i-1] * i

ans = 0
for p in itertools.product(*C):
    x, y = 0, 0
    a = []
    for i in p:
        x += i[0]
        y += i[1]
        a.append(i[2])
    if Gx == x and Gy == y:
        b = 1
        for aa in a:
            b *= F[aa]
        ans += F[sum(a)] / b

print ans % 1000000007

