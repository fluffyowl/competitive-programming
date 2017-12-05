def ok(s):
    n = len(s)
    for i in xrange(n/2):
        if s[i] != s[n-i-1]:
            return False
    return True

S = raw_input()
N = len(S)
for i in xrange(len(S)+1):
    T = S + S[:i][::-1]
    if (ok(T)):
        print i
        exit() def ok(s):
    n = len(s)
    for i in xrange(n/2):
        if s[i] != s[n-i-1]:
            return False
    return True

S = raw_input()
N = len(S)
for i in xrange(len(S)+1):
    T = S + S[:i][::-1]
    if (ok(T)):
        print i
        exit()
