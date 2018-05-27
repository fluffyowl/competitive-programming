S = raw_input()
N = len(S)
o = S.count('o')
x = S.count('x')

for i in xrange(N):
    print '%.09f' % (1.0 * o / (o + x) * 100)
    if S[i] == 'o':
        o -= 1
    else:
        x -= 1

