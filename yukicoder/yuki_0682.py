a, b = map(int, raw_input().split())
ans = 0
for i in xrange(a, b+1):
    if (a + b + i) % 3 == 0:
        ans += 1
print ans

