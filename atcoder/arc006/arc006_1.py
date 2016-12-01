a = raw_input().split()
b = raw_input()
c = raw_input().split()
d = len(set(a)&set(c))
if d == 6:
    print 1
elif d == 5 and set(c)-set(a) == set([b]):
    print 2
elif d == 5:
    print 3
elif d == 4:
    print 4
elif d == 3:
    print 5
else:
    print 0
