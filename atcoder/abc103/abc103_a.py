from itertools import permutations

A = map(int, raw_input().split())
ans = float('inf')
for p in permutations([0, 1, 2]):
    tmp = abs(A[p[0]] - A[p[1]]) + abs(A[p[1]] - A[p[2]])
    ans = min(ans, tmp)
print ans
