a, b = map(int, raw_input().split())
if a > 0:
    print 'Positive'
elif b >= 0:
    print 'Zero'
elif (b-a)%2:
    print 'Positive'
else:
    print 'Negative'
