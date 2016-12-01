import sys

table = [True for i in xrange(1001)]

for i in xrange(2, 1001):
    if not table[i]:
        continue
    print '?', i
    sys.stdout.flush()
    if raw_input() == 'N':
        j = i
        while j <= 1000:
            table[j] = False
            j += i

for i in xrange(1000, 0, -1):
    if table[i]:
        print '!', i
        sys.stdout.flush()
        break
