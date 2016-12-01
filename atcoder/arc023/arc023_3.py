MOD = 10**9 + 7

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

n = input()
a = map(int, raw_input().split())
sg = []
for i in range(1, n-1):
    if a[i] == -1:
        if a[i-1] != -1:
            s = a[i-1]
            si = i-1
        if a[i+1] != -1:
            g = a[i+1]
            gi = i+1
            sg.append((s, g, gi-si-1))

ans = 1
for s, g, i in sg:
    ans = (ans*ncr(g-s+i, i)) % MOD
print ans
