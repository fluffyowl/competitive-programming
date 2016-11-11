import math
from fractions import gcd
L = input()/4
R =  int(math.sqrt(L))+1
ans = 0

for n in xrange(1, R):
    for m in xrange(n+1, R, 2):
        if gcd(m, n) != 1:
            continue
        a, b, c = m*m-n*n, 2*m*n, m*m+n*n
        if a+b+c <= L:
            ans += 1
print ans

