from collections import Counter
input()
print sum(c==1 for c in Counter(raw_input().split()).values())
