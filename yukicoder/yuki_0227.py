from collections import Counter
a = sorted(Counter(raw_input().split()).values())
if a == [2,3]:
    print 'FULL HOUSE'
elif a == [1,1,3]:
    print 'THREE CARD'
elif a == [1,2,2]:
    print 'TWO PAIR'
elif a == [1,1,1,2]:
    print 'ONE PAIR'
else:
    print 'NO HAND'

