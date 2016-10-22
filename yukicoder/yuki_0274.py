N, M = map(int, raw_input().split())
blocks = [map(int, raw_input().split()) for _ in xrange(N)]
rinsetsu = [[] for _ in xrange(N)]

for i in xrange(N):
    for j in xrange(i+1, N):
        L1, R1 = blocks[i]
        L2, R2 = blocks[j]
        L3, R3 = M-R2-1, M-L2-1
        b1 = not(R2 < L1 or R1 < L2)
        b2 = not(R3 < L1 or R1 < L3)
        if b1 and b2:
            print 'NO'
            exit()
        elif b1 or b2:
            rinsetsu[i].append(j)
            rinsetsu[j].append(i)

def dfs(start, color):
    color[start] = 0
    stack = [start]
    while len(stack) > 0:
        node = stack.pop()
        next_color = (color[node]+1)%2
        for next_node in rinsetsu[node]:
            if color[next_node] == -1:
                color[next_node] = next_color
                stack.append(next_node)
            elif color[next_node] != next_color:
                return False
    return color

color = [-1 for _ in xrange(N)]
for i in xrange(N):
    if color[i] == -1:
        color = dfs(i, color)
    if not color:
        print 'NO'
        exit()
print 'YES'

