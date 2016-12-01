N = int(raw_input())
rinsetsu = [[] for i in xrange(N)]
for i in xrange(N-1):
    a, b = map(int, raw_input().split())
    a -= 1
    b -= 1
    rinsetsu[a].append(b)
    rinsetsu[b].append(a)

def dfs(start):
    max_d = 0
    max_v = None
    stack = [(start, 0)]
    visited = [False for i in xrange(N)]

    while len(stack) > 0:
        node, depth = stack.pop()
        if depth > max_d:
            max_d = depth
            max_v = node
        visited[node] = True
        for n_node in rinsetsu[node]:
            if visited[n_node]:
                continue
            stack.append((n_node, depth+1))

    return max_v

u = dfs(0)
v = dfs(u)
print u+1, v+1
