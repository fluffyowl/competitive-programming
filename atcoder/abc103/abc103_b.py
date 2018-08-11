S = raw_input()
T = raw_input()
N = len(S)

for i in xrange(N + 1):
    if S == T:
        print "Yes"
        exit()
    S = S[1:N] + S[0]
print "No"
