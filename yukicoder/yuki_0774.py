from random import randint
from itertools import permutations

def miller_rabin(n, k = 10):
    if n == 1:
        return False
    if n == 2:
        return True
    if (n & 1) == 0:
        return False
    if sum(map(int, list(str(n)))) % 3 == 0:
        return False
    d = n - 1
    s = 0
    while (d & 1) == 0:
        s += 1
        d >>= 1
    for _ in xrange(k):
        a = randint(1, n - 1)
        if pow(a, d, n) == 1:
            continue
        composite = True
        r = 1
        for i in xrange(s):
            if pow(a, r * d, n) == n - 1:
                composite = False
                break
            r *= 2
        if composite:
            return False
    return True


N = input()
A = sorted(map(int, raw_input().split()))
S = set()
ans = -1

for p in permutations(A):
    n = int(''.join(map(str, p)))
    if n in S or n <= ans:
        continue
    if miller_rabin(n):
        ans = max(ans, n)
    S.add(n)

print ans

