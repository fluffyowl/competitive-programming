def prime_table(n):
    L = [True for _ in xrange(n + 1)]
    i = 2
    while i * i <= n:
        if L[i]:
            j = i + i
            while j <= n:
                L[j] = False
                j += i
        i += 1
    table = [i for i in xrange(n + 1) if L[i] and i >= 2]
    return table

M = input()
N = input()
C = map(int, raw_input().split())

dist = [float('-inf') for _ in xrange(M+1)]
dist[M] = 0
for i in xrange(M, 0, -1):
    for c in C:
        if i-c >= 0:
            dist[i-c] = max(dist[i]+1, dist[i-c])
print sum(dist[p] for p in prime_table(M) if dist[p] != float('-inf'))+max(dist)
