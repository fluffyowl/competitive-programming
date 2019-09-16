N, K = map(int, input().split())
X = min(N, K)
ans = X * (2 * (N - X + 1) + (X - 1)) // 2 + 1
print (ans)
