from collections import Counter

def alp(c):
    return ord(c) - ord('a')

n = input()
C = [0 for _ in xrange(26)]
s = raw_input()
for c in s:
    C[alp(c)] += 1


for i in xrange(n-1):
    s = raw_input()
    D = [0 for _ in xrange(26)]
    for c in s:
        D[alp(c)] += 1
    for j in xrange(26):
        C[j] = min(C[j], D[j])

ans = ""
for i in xrange(26):
    ans += chr(ord('a')+i) * C[i]
print ans
