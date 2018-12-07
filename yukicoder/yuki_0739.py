S = raw_input()
N = len(S)
if N % 2 == 1:
    print "NO"
    exit()
if (S[:N/2] == S[N/2:]):
    print "YES"
else:
    print "NO"
