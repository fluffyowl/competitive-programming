import sys

N = 1000000001
print 0, 0
sys.stdout.flush()
d1 = int(raw_input())
if d1 == 0:
    exit()
print N-1, 0
sys.stdout.flush()
d2 = int(raw_input())
if d2 == 0:
    exit()

x = (d1 - d2 + N - 1) / 2
y = d1 - x
print x, y

