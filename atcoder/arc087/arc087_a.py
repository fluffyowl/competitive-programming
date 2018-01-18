from collections import Counter

N = input()
A = map(int, raw_input().split())
C = Counter(A)
ans = 0

for k, v in C.items():
    if k > v:
        ans += v
    elif k < v:
        ans += v - k

print ans from collections import Counter

N = input()
A = map(int, raw_input().split())
C = Counter(A)
ans = 0

for k, v in C.items():
    if k > v:
        ans += v
    elif k < v:
        ans += v - k

print ans
