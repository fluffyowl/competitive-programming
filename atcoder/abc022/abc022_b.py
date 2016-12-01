N = int(raw_input())
visited = set()
s = 0
for i in range(N):
    a = raw_input()
    if a in visited:
        s += 1
    else:
        visited.add(a)
print s
