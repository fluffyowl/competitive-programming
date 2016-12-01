N = int(raw_input())
ans = float('-inf')
for i in range(N):
    a = map(int, raw_input().split())
    a = sum(a[:4]) + a[4] * 110.0 / 900
    ans = max(ans, a)
print ans
