N = input()
seq = map(int, raw_input().split())
n = N
ans = 0
for i in xrange(N-1, -1, -1):
    if seq[i] == n:
        n -= 1
        ans += 1
print N-ans

