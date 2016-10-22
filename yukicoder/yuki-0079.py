from collections import Counter
N = input()
c = Counter(map(int, raw_input().split()))
max_v = -1
max_n = -1
for i in xrange(1, 7):
    if c[i] >= max_v:
        max_v = c[i]
        max_n = i
print max_n

