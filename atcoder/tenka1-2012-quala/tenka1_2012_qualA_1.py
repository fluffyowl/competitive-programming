a, b, c = 0, 0, 1
for i in xrange(input()):
    a, b, c = a+b, c, a+b
print a+b+c
