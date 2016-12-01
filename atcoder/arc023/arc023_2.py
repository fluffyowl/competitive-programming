R, C, D = map(int, raw_input().split())
ans = [0 for i in range(R+C)]
for i in range(R):
    for j, c in enumerate(map(int, raw_input().split())):
        ans[i+j] = max(ans[i+j], c)
print max(a for i, a in enumerate(ans) if i%2==D%2 and D>=i)
