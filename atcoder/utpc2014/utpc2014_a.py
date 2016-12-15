S = raw_input().split()
last_not = -1
for i in xrange(len(S)):
    if S[i] == 'not' and last_not == -1:
        last_not = i
    elif S[i] != 'not' and last_not != -1:
        last_not += (i-last_not) % 2
        for j in xrange(last_not, i):
            S[j] = ''
        last_not = -1
print ' '.join(filter(None, S))
