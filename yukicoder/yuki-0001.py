N, C, V = input(), input(), input()
S = map(int, raw_input().split())
T = map(int, raw_input().split())
Y = map(int, raw_input().split())
M = map(int, raw_input().split())

rinsetsu = [[] for i in xrange(N)]
for i in xrange(V):
    rinsetsu[S[i]-1].append((T[i]-1, Y[i], M[i]))

mem = {}
def rec(node, cost):
    if (node, cost) in mem:
        return mem[(node, cost)]

    if cost < 0:
        return float('inf')
    
    if node == N-1:
        return 0

    minv = float('inf')
    for t, y, m in rinsetsu[node]:
        a = rec(t, cost-y) + m
        if a < minv:
            minv = a

    mem[(node, cost)] = minv
    return minv

ans = rec(0, C)
print -1 if ans == float('inf') else ans

