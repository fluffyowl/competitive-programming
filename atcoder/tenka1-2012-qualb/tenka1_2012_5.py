a, b, c = map(int, raw_input().split())
for i in xrange(1, 128):
    if i%3==a and i%5==b and i%7==c:
        print i
