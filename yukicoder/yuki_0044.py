N = input()
ans = [0 for i in xrange(N+1)]
ans[0], ans[1] = 1, 1
for i in xrange(2, N+1):
    ans[i] = ans[i-1] + ans[i-2]
print ans[N]

