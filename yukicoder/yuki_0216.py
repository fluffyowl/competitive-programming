N = input()
a = map(int, raw_input().split())
b = map(int, raw_input().split())
c = {0:0}

for i in xrange(N):
    if b[i] in c:
        c[b[i]] += a[i]
    else:
        c[b[i]] = a[i]

print 'YES' if max(c.values()) <= c[0] else 'NO'

