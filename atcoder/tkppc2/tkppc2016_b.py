N, M = map(int, raw_input().split())
vt = sorted([map(int, raw_input().split()) for _ in xrange(N)], key=lambda x:-x[1])

mem = {}
def rec(order, t):
    if order >= N:
        return 0
    if (order, t) in mem:
        return mem[(order, t)]
    if t < vt[order][1]:
        mem[(order, t)] = rec(order+1, t)
    else:
        mem[(order, t)] = max(vt[order][0]+rec(order+1, t-vt[order][1]), rec(order+1, t))

    return mem[(order, t)]

print rec(0, M)
