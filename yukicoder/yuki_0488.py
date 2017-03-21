from itertools import combinations, permutations

n, m = map(int, raw_input().split())
adj = [set() for _ in xrange(n)]
for i in xrange(m):
    a, b = map(int, raw_input().split())
    adj[a].add(b)
    adj[b].add(a)


ans = 0
for c in combinations(range(n), 4):
    for p in permutations(c):
        if all(p[i] in adj[p[(i+1)%4]] for i in xrange(4)) and p[0] not in adj[p[2]] and p[1] not in adj[p[3]]:
            ans += 1
            break
print ans

