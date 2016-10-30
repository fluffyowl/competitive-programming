K = input()
dp = [0 for _ in xrange(K+7)]
for i in xrange(K-1, -1, -1):
    dp[i] = sum(dp[i+j] for j in xrange(1, 7))/6.+1
print dp[0]

