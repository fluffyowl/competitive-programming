n, k = map(int, raw_input().split())
d = map(lambda x: int(x)-1, raw_input().split())
f = [0 for _ in xrange(n)]
for i, e in enumerate(d):
    f[e] = i

used = set()

hoge = []
x = 0
for i in xrange(n):
    x = i
    y = 0
    while x not in used:
        used.add(x)
        x = f[x]
        y += 1
    if y > 0:
        hoge.append(y)

x = sum(a-1 for a in hoge)
print "YES" if x % 2 == k % 2 and x <= k else "NO"

