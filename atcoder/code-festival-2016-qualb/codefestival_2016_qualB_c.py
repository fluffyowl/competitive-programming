W, H = map(int, raw_input().split())
p = sorted([(i, int(raw_input())) for i in xrange(W)], key=lambda x:-x[1])
q = sorted([(i, int(raw_input())) for i in xrange(H)], key=lambda x:-x[1])
ans = 0
pe, qe, ae = 0, 0, (W+1)*(H+1)-1
while len(p)> 0 or len(q) > 0:
    if len(q) == 0 or (len(p) > 0 and p[-1][1] <= q[-1][1]):
        i, cost = p.pop()
        pe += 1
        ans += cost*(H+1-qe)
    else:
        j, cost = q.pop()
        qe += 1
        ans += cost*(W+1-pe)

print ans
