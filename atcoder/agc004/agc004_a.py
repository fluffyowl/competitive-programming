a = sorted(map(int, raw_input().split()))
if any(x%2==0 for x in a):
    print 0
else:
    print a[0]*a[1]
