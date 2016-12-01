from itertools import permutations

def is_prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    i = 3
    while i * i <= n:
        if n%i == 0:
            return False
        i += 2
    return True

d = '13579'
S = raw_input()
st = list(set(S))
if len(st) > 5:
    print -1
    exit()

for p in permutations(d, len(st)):
    N = S
    for i, c in enumerate(p):
        N = N.replace(st[i], c)
    if is_prime(int(N)):
        print N
        exit()
print -1
