from collections import Counter
print 'Yes' if all(a%2-1 for a in Counter(raw_input()).values()) else 'No'
