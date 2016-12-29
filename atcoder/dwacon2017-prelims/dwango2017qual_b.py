S = raw_input()
A = ['0'] + ['' for _ in xrange(len(S))]
N = len(S)
ans = 0
tmp = 0
for i in xrange(0, len(S), 2):
    if i >= N or i+1 >= N:
        break
    if (S[i] == '2' or S[i] == '?') and (S[i+1] == '5' or S[i+1] == '?'):
        tmp += 2
    else:
        ans = max(ans, tmp)
        tmp = 0

ans = max(ans, tmp)
tmp = 0
for i in xrange(1, len(S) - len(S)%2, 2):
    if i>= N or i+1 >= N:
        break
    if (S[i] == '2' or S[i] == '?') and (S[i+1] == '5' or S[i+1] == '?'):
        tmp += 2
    else:
        ans = max(ans, tmp)
        tmp = 0

print max(ans, tmp)
