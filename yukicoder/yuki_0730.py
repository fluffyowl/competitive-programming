from collections import Counter

S = list(raw_input())
C = Counter(S)
print "YES" if all(c <= 1 for c in C.values()) else "NO"

