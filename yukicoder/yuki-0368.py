MOD = 10**9+7

def prime_decomposition(n):
    i = 2
    table = {}
    while i * i <= n:
        while n % i == 0:
            n /= i
            table[i] = table.get(i, 0) + 1
        i += 1
    if n > 1:
        table[n] = table.get(n, 0) + 1
    return table

N, K = map(int, raw_input().split())
A = map(int, raw_input().split())
d = {}
for a in A:
    for k, v in prime_decomposition(a).items():
        if k in d:
            d[k].append(v)
        else:
            d[k] = [v]

ans = 1
for k, v in d.items():
    nv = sorted(v, reverse=True)
    for i in xrange(min(K, len(v))):
        ans = ans*k**nv[i] % MOD
print ans

