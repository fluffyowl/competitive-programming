from collections import Counter
raw_input()
a, b = Counter(raw_input()), Counter(raw_input())
print max(a[i]/b[i]+(a[i]%b[i]>0) for i in a) if len(a&b) == len(a) else -1
