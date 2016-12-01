from bisect import bisect_left
N = input()
C = [int(raw_input()) for _ in xrange(N)]
dp = [float('inf') for _ in xrange(N+1)]
dp[0] = float('-inf')

for i in xrange(N):
    dp[bisect_left(dp, C[i])] = C[i]

print N - bisect_left(dp, float('inf')) + 1
