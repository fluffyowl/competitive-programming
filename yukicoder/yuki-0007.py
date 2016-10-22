def prime_table(n):
    list = [True for _ in xrange(n + 1)]
    i = 2
    while i * i <= n:
        if list[i]:
            j = i + i
            while j <= n:
                list[j] = False
                j += i
        i += 1

    table = [i for i in xrange(n + 1) if list[i] and i >= 2]
    return table

N = input()
table = prime_table(N)
grundy = [0 for _ in xrange(N+1)]
grundy[0] = 1
grundy[1] = 1
for i in xrange(3, N+1):
    a = []
    for p in table:
        if i-p < 0:
            break
        a.append(grundy[i-p])
    j = 0
    while j in a:
        j += 1
    grundy[i] = j

print 'Win' if grundy[N]>0 else 'Lose'

