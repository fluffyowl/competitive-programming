from collections import Counter
n = input()
c = Counter([raw_input() for i in xrange(n)])
print 'YES' if max(c.values()) <= n/2+n%2 else 'NO'

