N = input()
S = set()
last = '.'
for i in xrange(N):
    s = raw_input()
    if s in S:
        print "No"
        exit()
    if last != '.' and s[0] != last:
        print "No"
        exit()
    last = s[-1]
    S.add(s)
print "Yes"
