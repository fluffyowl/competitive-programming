sosuu = {}
def prime_decomposition(n):
    if n in sosuu:
        return sosuu[n]
    i = 2
    table = {}
    while i * i <= n:
        while n % i == 0:
            n /= i
            table[i] = table.get(i, 0) + 1
        i += 1
    if n > 1:
        table[n] = table.get(n, 0) + 1
    sosuu[n] = table
    return table

N = input()
M = map(int, raw_input().split())
grundy = [-1 for _ in xrange(10001)]
grundy[1] = 0
for i in xrange(2, 10001):
    t = prime_decomposition(i)
    next_numbers = []
    for k, v in t.items():
        next_numbers.append(grundy[i/k])
        if v >= 2:
            next_numbers.append(grundy[i/k/k])
    mex = 0
    while mex in next_numbers:
        mex += 1
    grundy[i] = mex

print 'Alice' if reduce(lambda x,y:x^y, map(lambda x:grundy[x], M), 0) else 'Bob'
