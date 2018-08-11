from collections import Counter
N, X = map(int, raw_input().split())
A = map(int, raw_input().split())
C = Counter(A)
ans = 0

for a in A:
    if X-a in C:
        ans += C[X-a]

print ans

