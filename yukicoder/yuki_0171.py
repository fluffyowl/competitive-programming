from collections import Counter
import operator
MOD = 573

def gcd(a, b):
    while b:
        a, b = b, a%b
    return a

c = Counter(raw_input()).values()
bunbo = range(sum(c), 0, -1)
for n in c:
    for m in xrange(1, n+1):
        p = 0
        while m > 1:
            cd = gcd(m, bunbo[p])
            if cd > 1:
                bunbo[p] /= cd
                m /= cd
            p += 1

ans = 1
for b in bunbo:
    ans = ans * b % MOD
print (ans-1)%MOD

