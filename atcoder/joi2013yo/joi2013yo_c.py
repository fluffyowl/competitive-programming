import re

N = input()
S = raw_input()
ans = 0

if len(S) == 1:
    for i in xrange(N):
        T = raw_input()
        ans += S in T
    print ans
    exit()


for _ in xrange(N):
    T = raw_input()
    ok = 0
    i = 0
    while len(S) + i * (len(S) - 1) <= len(T):
        pat = '.*' + S[0]
        for j in xrange(len(S) - 1):
            pat += '.' * i + S[j + 1]
        pat += '.*'
        if re.match(pat, T):
            ok = 1
            break
        i += 1
    ans += ok

print ans
