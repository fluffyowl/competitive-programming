from collections import Counter

N, K = map(int, raw_input().split())
A = map(int, raw_input().split())
C = Counter(A)
D = C.items()[:]
D.sort(key=lambda x: x[1])

ans = 0
X = len(D)
for e, v in D:
    if X > K:
        ans += v
    X -= 1
print ans from collections import Counter

N, K = map(int, raw_input().split())
A = map(int, raw_input().split())
C = Counter(A)
D = C.items()[:]
D.sort(key=lambda x: x[1])

ans = 0
X = len(D)
for e, v in D:
    if X > K:
        ans += v
    X -= 1
print ans
