def ncr(n, r):
    if n - r < r:
        r = n-r
    if r == 0:
        return 1
    if r == 1:
        return n

    numerator = [0 for i in xrange(r)]
    denominator = [0 for i in xrange(r)]

    for k in xrange(r):
        numerator[k] = n - r + k + 1
        denominator[k] = k + 1
    
    for p in xrange(2, r+1):
        pivot = denominator[p-1]
        if pivot > 1:
            offset = (n-r) % p
            for k in range(p-1, r, p):
                numerator[k-offset] /= pivot
                denominator[k] /= pivot

    result = 1
    for k in xrange(r):
        if numerator[k] > 1:
            result = (result*numerator[k])

    return result

for i in xrange(input()):
    d, x, t = map(int, raw_input().split())
    print 'AC' if ncr(x+d-1, d-1) <= t else 'ZETUBOU'

