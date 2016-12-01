N, M, D = map(int, raw_input().split())
A = map(int, raw_input().split())
nums = range(N)

for i in A:
    nums[i-1], nums[i] = nums[i], nums[i-1]

links = [-1 for _ in xrange(N)]
for i in xrange(N):
    links[nums[i]] = i
links_list = []
visited = [False for _ in xrange(N)]
for i in xrange(N):
    if not visited[i]:
        s = [i]
        visited[i] = True
        n = links[i]
        while n != i:
            s.append(n)
            visited[n] = True
            n = links[n]
        links_list.append(s)

ans = [0 for _ in xrange(N)]
for s in links_list:
    for i, e in enumerate(s):
        ans[e] = s[(i+D)%len(s)]

for a in ans:
    print a+1
