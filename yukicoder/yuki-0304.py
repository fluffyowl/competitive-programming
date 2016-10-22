import sys
for i in xrange(1000):
    print '%03d'%i
    sys.stdout.flush()
    if raw_input() == 'unlocked':
        break

