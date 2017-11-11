S = raw_input()
T = raw_input()
N = len(S)
M = len(T)
ans = '{'

for i in xrange(N-M+1):
    if all(S[i+j] == T[j] or S[i+j] == '?' for j in xrange(M)):
        tmp = list(S)
        for j in xrange(M):
            tmp[i+j] = T[j]
        tmp = ''.join(tmp)
        tmp = tmp.replace('?', 'a')
        ans = min(ans, tmp)

print ans if ans != '{' else 'UNRESTORABLE'
