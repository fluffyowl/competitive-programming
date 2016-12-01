from collections import Counter
raw_input()
a = Counter(raw_input().split())
b = Counter(raw_input().split())
print sum(min(a[c], b[c]) for c in a)
