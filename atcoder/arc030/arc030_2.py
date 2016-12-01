def reduce_graph(root, children, houseki):
    def rec_dfs(node):
        removals = []
        for c in children[node]:
            if not rec_dfs(c):
                removals.append(c)
        for i in removals[::-1]:
            children[node].remove(i)
        if len(children[node]) == 0 and houseki[node] == 0:
            return False
        else:
            return True
    rec_dfs(root)
    return children


def solve():
    n, root = map(int, raw_input().split())
    root -= 1
    rinsetsu = [[] for i in range(n)]
    houseki = map(int, raw_input().split())
    for i in range(n-1):
        x, y = map(lambda x:int(x)-1, raw_input().split())
        rinsetsu[x].append(y)
        rinsetsu[y].append(x)
    children = [[] for i in range(n)]

    stack = [(root, None)]
    while len(stack) != 0:
        node, parent = stack.pop()
        for child in rinsetsu[node]:
            if child != parent:
                children[node].append(child)
                stack.append((child, node))

    children = reduce_graph(root, children, houseki)
    s = 0
    for i in range(n):
        s += len(children[i]) * 2

    print s

solve()
