from itertools import permutations

A, B, C = raw_input().split()
ans = 0

for p in permutations([A, B, C, '+']):
    if p[0] == '+' or p[3] == '+':
        continue
    ans = max(ans, eval(''.join(p)))
print ans
