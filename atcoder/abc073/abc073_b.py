N = input()
ans = 0
for i in xrange(N):
    l, r = map(int, raw_input().split())
    ans += r - l + 1
print ans
