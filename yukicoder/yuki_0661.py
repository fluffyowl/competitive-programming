N = input()
for _ in xrange(N):
    x = int(raw_input())
    if x % 10 == 0 and x % 8 == 0:
        print "ikisugi"
    elif x % 10 == 0:
        print "sugi"
    elif x % 8 == 0:
        print "iki"
    else:
        print x / 3
