from fractions import Fraction

N = int(raw_input())
rinsetsu = {}
units = set()
for i in xrange(N):
    u1, m, u2 = raw_input().split()
    m = int(m)
    units.add(u1)
    units.add(u2)
    if u1 == u2:
        continue
    if u2 in rinsetsu:
        rinsetsu[u2].append((u1, Fraction(m)))
    else:
        rinsetsu[u2] = [(u1, Fraction(m))]
    if u1 in rinsetsu:
        rinsetsu[u1].append((u2, Fraction(1, m)))
    else:
        rinsetsu[u1] = [(u2, Fraction(1, m))]

if len(units) == 1:
    u = units.pop()
    print '1{0}=1{1}'.format(u, u)
    exit()

dists = {u:0 for u in units}
u0 = units.pop()
dists[u0] = 1
stack = [(u0, Fraction(1))]
visited = set()
while len(stack) != 0:
    unit, dist = stack.pop()
    if unit in visited:
        continue
    dists[unit] = dist
    visited.add(unit)
    if unit not in rinsetsu:
        continue
    for u2, d in rinsetsu[unit]:
        stack.append((u2, dist*d))

ans = sorted(dists.items(), key=lambda x:x[1])
print '1{0}={1}{2}'.format(ans[-1][0], int(ans[-1][1]/ans[0][1]), ans[0][0])
