def root(uf, a):
    root_a = a
    visited = []
    while uf[root_a] >= 0:
        visited.append(root_a)
        root_a = uf[root_a]
    for v in visited:
        uf[v] = root_a
    return root_a

N, M = map(int, raw_input().split())

queries1 = []
for i in range(M):
    a, b, y = map(int, raw_input().split())
    a, b = a-1, b-1
    queries1.append((a, b, y))
queries1.sort(key=lambda x:x[2], reverse=True)

Q = int(raw_input())
queries2 = []
for i in range(Q):
    v, w = map(int, raw_input().split())
    v -= 1
    queries2.append((i, v, w))
queries2.sort(key=lambda x:x[2], reverse=True)

uf = [-1 for i in range(N)]
ans = [1 for i in range(Q)]
p1 = 0
p2 = 0
while True:
    if p1 < M and p2 < Q:
        if queries1[p1][2] > queries2[p2][2]:
            query = 1
        else:
            query = 2
    elif p1 < M:
        query = 1
    elif p2 < Q:
        query = 2
    else:
        break
    if query == 1:
        a, b = queries1[p1][0], queries1[p1][1]
        root_a = root(uf, a)
        root_b = root(uf, b)
        if root_a == root_b:
            p1 += 1
            continue
        if -uf[root_a] > -uf[root_b]:
            uf[root_a] += uf[root_b]
            uf[root_b] = root_a
        else:
            uf[root_b] += uf[root_a]
            uf[root_a] = root_b
        p1 += 1
    else:
        ans[queries2[p2][0]] = -uf[root(uf, queries2[p2][1])]
        p2 += 1

for a in ans:
    print a
