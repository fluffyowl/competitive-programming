X, Y = map(int, raw_input().split())
if X == 0 and Y == 0:
    print 0
elif Y == 0:
    print 1
elif X == 0:
    print 2
elif X == Y:
    print 0
elif abs(X) == abs(Y):
    print 3
else:
    print -1
