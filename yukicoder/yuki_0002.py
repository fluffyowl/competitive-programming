def prime_decomposition(n):
    i = 2
    table = {}
    while i * i <= n:
        while n % i == 0:
            n /= i
            if i in table:
                table[i] += 1
            else:
                table[i] = 1
        i += 1
    if n > 1:
        if n in table:
            table[n] += 1
        else:
            table[n] = 1
    return table

mem = {}
def grundy(n):
    if n <= 1:
        return 0
    if n in mem:
        return mem[n]
    
    table = prime_decomposition(n)
    children = []
    for k, v in table.items():
        for i in xrange(1, v+1):
            children.append(grundy(n/(k**i)))
    i = 0
    while i in children:
        i += 1
    mem[n] = i
    return i

print 'Alice' if grundy(input()) else 'Bob'

