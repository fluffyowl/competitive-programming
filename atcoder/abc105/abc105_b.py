N = input()
ok = [False for _ in xrange(N+1)]
for i in xrange(4, N+1, 4):
    ok[i] = True
for i in xrange(7, N+1, 7):
    ok[i] = True
for i in xrange(N+1):
    if ok[i] and i + 4 <= N:
        ok[i+4] = True
    elif ok[i] and i + 7 <= N:
        ok[i+7] = True
if ok[N]:
    print "Yes"
else:
    print "No"
