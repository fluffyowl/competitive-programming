N = input()
ans = []
if N % 2 == 1:
    for i in xrange(N):
        ans.append((1 << 20) + i)
else:
    for i in xrange(N-1):
        ans.append((1 << 20) + i)
    ans.append(1)

for i in xrange(N):
    x = 0
    for j in xrange(N):
        if i != j:
            x ^= ans[j]
    print ans[i], x, ans[i] > x
