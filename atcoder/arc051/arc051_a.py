x1, y1, r = map(int, raw_input().split())
x2, y2, x3, y3 = map(int, raw_input().split())

if x2 <= (x1-r) and (x2+r) <= x3 and y2 <= (y1-r) and (y1+r) <= y3:
    print 'NO'
    print 'YES'
elif all((x-x1)**2+(y-y1)**2 <= r**2 for x, y in [(x2, y2), (x2, y3), (x3, y2), (x3, y3)]):
    print 'YES'
    print 'NO'
else:
    print 'YES'
    print 'YES'
