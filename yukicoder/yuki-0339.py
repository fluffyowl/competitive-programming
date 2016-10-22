def gcd(a, b):
    while b:
        a, b = b, a%b
    return a

n = input()
print 100/reduce(gcd, [int(raw_input()) for _ in xrange(n)])

