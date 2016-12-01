s = raw_input()
n = len(s)
diff = len([1 for i in range(n/2) if s[i] != s[-i-1]])
if diff == 0:
    print 25*(n-n%2)
elif diff == 1:
    print 25*(n-2) + 48
else:
    print 25*(n-n%2) + 25*(n%2)
