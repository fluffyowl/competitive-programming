from collections import Counter
n, m = raw_input().split()
a = max(Counter(raw_input().split()).items(), key=lambda x:x[1])
print a[0] if a[1] > int(n)/2 else '?'
