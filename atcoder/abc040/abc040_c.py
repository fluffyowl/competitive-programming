n = int(raw_input())
a = map(int, raw_input().split())

ans = [0 for i in range(n)]
ans[0] = 0
ans[1] = abs(a[1] - a[0])

for i in range(2, n):
    ans[i] = min(ans[i-2] + abs(a[i] - a[i-2]),
                 ans[i-1] + abs(a[i] - a[i-1]))
print ans[n-1]
