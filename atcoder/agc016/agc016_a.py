S = raw_input()
N = len(S)

for i in xrange(0, N):
    r = i + 1
    s = [set() for _ in xrange(N - i)]
    for j in xrange(N-i):
        for k in xrange(r):
            s[j].add(S[j + k])
    for j in xrange(1, N-i):
        s[0] &= s[j]
    if len(s[0]) > 0:
        print i
        exit()
