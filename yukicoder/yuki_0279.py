from collections import Counter
c = Counter(raw_input())
print min(c['t'], c['r'], c['e']/2)
