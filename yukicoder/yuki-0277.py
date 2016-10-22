from collections import deque

N = input()
rinsetsu = [[] for _ in xrange(N)]
for i in xrange(N-1):
    x, y = map(int, raw_input().split())
    x -= 1
    y -= 1
    rinsetsu[x].append(y)
    rinsetsu[y].append(x)
ans = [float('inf') for _ in xrange(N)]

def dfs(start):
    stack = [(start, None)]
    leaves = []
    while len(stack) > 0:
        node, parent = stack.pop()
        if len(rinsetsu[node]) == 1 and parent is not None:
            leaves.append(node)
            continue
        for nn in rinsetsu[node]:
            if nn == parent:
                continue
            stack.append((nn, node))
    return leaves

def bfs(starts):
    q = deque()
    for s in starts:
        q.append((s, 0))
    visited = [False for _ in xrange(N)]
    while len(q) > 0:
        node, depth = q.popleft()
        if visited[node]:
            continue
        visited[node] = True
        ans[node] = min(ans[node], depth)
        for nn in rinsetsu[node]:
            if not visited[nn]:
                q.append((nn, depth+1))

leaves = dfs(0) + [0]
bfs(leaves)
for a in ans:
    print a

