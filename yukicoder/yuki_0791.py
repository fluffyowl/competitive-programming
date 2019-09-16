S = raw_input()
if len(S) == 1:
    print -1
    exit()

if S[0] != "1":
    print -1
    exit()
for i in xrange(1, len(S)):
    if S[i] != "3":
        print -1
        exit()

print len(S) - 1
