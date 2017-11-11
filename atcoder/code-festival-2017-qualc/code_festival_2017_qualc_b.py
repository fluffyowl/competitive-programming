from itertools import product

N = int(raw_input())
A = map(int, raw_input().split())
ans = 0

for p in product((-1, 0, 1), repeat=N):
    B = A[:]
    for i in xrange(N):
        B[i] += p[i]
    if sum(b % 2 == 0 for b in B) > 0:
        ans += 1

print ans
