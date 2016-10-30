x, y, d = map(int, raw_input().split())
if -x+d > y:
    print 0
elif d > y and d > x:
    print x+y-d+1
elif d > y:
    print y+1
elif d > x:
    print x+1
else:
    print d+1

