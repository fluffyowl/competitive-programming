k, s = map(int, raw_input().split())
ans = 0
for x in xrange(k+1):
    for y in xrange(k+1):
        z = s - x - y
        if 0 <= z <= k:
            ans += 1
print ans
