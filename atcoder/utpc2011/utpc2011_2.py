S = raw_input()
N = len(S)
ans = 0
for i in xrange(N/2):
    hoge = S[i] + S[N-i-1]
    if hoge != 'ww' and hoge != 'ii' and hoge != '()' and hoge != ')(':
        ans += 1

if N % 2 == 1 and (S[N/2] == ')' or S[N/2] == '('):
    ans += 1

print ans
