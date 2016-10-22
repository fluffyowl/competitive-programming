a = dict((x, y) for x, y in zip('GCP', map(int, raw_input().split())))
s = raw_input()
b = dict((c, s.count(c)) for c in 'GCP')
ans = 0

for s, t in zip('GCP', 'CPG'):
    if a[s] <= b[t]:
        ans += a[s]*3
        b[t] -= a[s]
        a[s] = 0
    else:
        ans += b[t]*3
        a[s] -= b[t]
        b[t] = 0

for s in 'GCP':
    if a[s] <= b[s]:
        ans += a[s]
        b[s] -= a[s]
        a[s] = 0
    else:
        ans += b[s]
        a[s] -= b[s]
        b[s] = 0
        
print ans

