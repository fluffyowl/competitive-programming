MOD = 1000000007

def ncr(n, r):
    if n - r < r:
        r = n-r
    if r == 0:
        return 1
    if r == 1:
        return n

    numerator = [0 for i in range(r)]
    denominator = [0 for i in range(r)]

    for k in range(r):
        numerator[k] = n - r + k + 1
        denominator[k] = k + 1
    
    for p in range(2, r+1):
        pivot = denominator[p-1]
        if pivot > 1:
            offset = (n-r) % p
        for k in range(p-1, r, p):
            numerator[k-offset] /= pivot
            denominator[k] /= pivot

    result = 1
    for k in range(r):
        if numerator[k] > 1:
            result = (result*numerator[k]) % MOD

    return result

W, H = map(lambda x:int(x)-1, raw_input().split())
print ncr(W+H, W)
