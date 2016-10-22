from collections import Counter
a = []
for i in xrange(input()):
    a += map(int, raw_input().split())
c = Counter(a)
ans = 0
for k in c:
    ans += c[k]/2
    c[k] %= 2
ans += sum(c.values())/4
print ans

