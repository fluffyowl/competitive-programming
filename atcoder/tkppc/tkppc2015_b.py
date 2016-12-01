mi, mn = -1, -1
for i in xrange(input()):
    n = int(raw_input())
    if n > mn:
        mn = n
        mi = i
print mi+1
