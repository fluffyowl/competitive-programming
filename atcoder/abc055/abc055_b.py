m = 10**9 + 7
a = 1
for i in xrange(1, input()+1):
    a = a * i % m
print a
