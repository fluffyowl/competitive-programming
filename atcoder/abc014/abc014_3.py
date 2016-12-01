n = int(raw_input())
ans = [0 for i in xrange(1000001)]
for i in range(n):
    a, b = map(int, raw_input().split())
    ans[a] += 1
    if not b == len(ans) - 1:
        ans[b+1] -= 1

n = 0
for i in xrange(len(ans)):
    n += ans[i]
    ans[i] = n

print max(ans)
