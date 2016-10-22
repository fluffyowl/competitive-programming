def prime_table(k, n):
    list = [True for _ in xrange(n + 1)]
    i = 2
    while i * i <= n:
        if list[i]:
            j = i + i
            while j <= n:
                list[j] = False
                j += i
        i += 1

    table = [i for i in xrange(n + 1) if list[i] and i >= 2 and i >= k]
    return table

def _hash(n):
    while n >= 10:
        n = sum(int(s) for s in str(n))
    return n

K = input()
N = input()

p = prime_table(K, N)
h = map(_hash, p)

for r in xrange(9, 0, -1):
    for i in xrange(len(p)-r, -1, -1):
        if len(set(h[i:i+r])) == r:
            print p[i]
            exit()

