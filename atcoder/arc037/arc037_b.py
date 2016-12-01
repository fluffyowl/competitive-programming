N, M = map(int, raw_input().split())

rinsetsu = [[] for i in xrange(N)]
for i in xrange(M):
    u, v = map(int, raw_input().split())
    u -= 1
    v -= 1
    rinsetsu[u].append(v)
    rinsetsu[v].append(u)

def dfs(start):
    stack = [start]
    visited = set()

    while len(stack) > 0:
        node = stack.pop()
        visited.add(node)

        for n_node in rinsetsu[node]:
            if n_node in visited:
                continue
            stack.append(n_node)

    return visited
    
conj = []
for i in xrange(N):
    if all(i not in c for c in conj):
        conj.append(dfs(i))

conj_edges = [0 for i in xrange(len(conj))]
for n in rinsetsu:
    for m in n:
        for i, c in enumerate(conj):
            if m in c:
                conj_edges[i] += 1

ans = 0
for i in xrange(len(conj)):
    if conj_edges[i]/2 == len(conj[i]) - 1:
        ans += 1
print ans
