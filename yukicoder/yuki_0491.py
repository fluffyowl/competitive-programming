from itertools import product

N = input()
ans = 0

for i in xrange(1, 10):
    keta = i / 2 + i % 2
    for p in product('0123456789', repeat=keta):
        if p[0] == '0':
            continue
        q = p[::-1]
        if (i % 2 == 1):
            q = q[1:]
        r = int(''.join(p) + ''.join(q))
        r = 10**9*r + r
        if (r <= N):
            ans += 1
            
print ans

