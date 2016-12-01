def prime_decomposition(n):
    i = 2
    table = []
    while i * i <= n:
        while n % i == 0:
            n /= i
            table.append(i)
        i += 1
    if n > 1:
        table.append(n)
    return table

MOD = 1000000007
A, B = map(int, raw_input().split())
d = {}
for i in range(B+1, A+1):
    table = prime_decomposition(i)
    for j in table:
        d[j] = d[j] + 1 if j in d else 1

ans = 1
for i in d.values():
    ans = (ans * (i + 1)) % MOD
print ans
