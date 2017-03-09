from itertools import permutations

n, m = map(int, raw_input().split())

adj = [[] for _ in xrange(n)]
for i in xrange(m):
    a, b = map(int, raw_input().split())
    adj[a-1].append(b-1)
    adj[b-1].append(a-1)

ans = 0
for p in permutations(range(1, n)):
    f = True
    pos = 0
    for i in p:
        if i in adj[pos]:
            pos = i
        else:
            f = False
            break
    if f:
        ans += 1

print ans
