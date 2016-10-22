from collections import Counter
import operator
f = lambda x:reduce(operator.mul, range(1, x+1), 1)
v = Counter(raw_input()).values()
print f(sum(v))/reduce(operator.mul, map(f, v), 1)-1

