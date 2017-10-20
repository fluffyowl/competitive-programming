from collections import Counter

N = input()
A = map(int, raw_input().split())
C = Counter(A)

m1 = -1
m2 = -1

for k in C.keys():
    if C[k] >= 4 and m1 < k:
        m1, m2 = k, k
    elif C[k] >= 2 and m1 < k:
        m1, m2 = k, m1
    elif C[k] >= 2 and m2 < k:
        m2 = k

if m1 < 0 or m2 < 0:
    print 0
else:
    print m1 * m2
