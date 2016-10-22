N = input()
M = [int(raw_input()) for _ in xrange(N)]

mem = {}
def rec(p, b, acm):
    if b == ((1 << N) - 1):
        return 0
    if (p, b) in mem:
        return mem[(p, b)]
    m = float('inf')
    for i in xrange(N):
        if (1 << i) & b:
            continue
        price = max(0, M[i]-(acm%1000))
        m = min(m, rec(i, b+(1<<i), acm+M[i])+price)
    mem[(p, b)] = m
    return mem[(p, b)]
            
print min(rec(i, 1<<i, M[i])+M[i] for i in xrange(N))

