N = input()
a = sorted([input() for _ in xrange(3)])[::-1]
i = 0
while N > 0:
    N -= a[i%3]
    i += 1
print i
