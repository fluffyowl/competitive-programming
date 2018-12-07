X, Y = map(int, raw_input().split())

A = 3 * X - Y
B = 3 * Y - X

if A >= 0 and B >= 0 and A % 8 == 0 and B % 8 == 0:
    print "Yes"
else:
    print "No"
