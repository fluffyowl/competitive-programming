from collections import Counter
n = input()
A = map(int, raw_input().split())
C = Counter(A)
ans = 0
for k in C.keys():
    if C[k] >= 3:
        ans += (C[k]-1) / 2
        C[k] = 1 if C[k] % 2 == 1 else 2
tmp = 0
for v in C.values():
    if v == 2:
        tmp += 1
#print ans, tmp
ans += tmp / 2 + tmp % 2
print n-ans*2
