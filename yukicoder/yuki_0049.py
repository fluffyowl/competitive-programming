S = raw_input().replace('+', ' + ').replace('*', ' * ').split()
ans = int(S[0])
for i in xrange(1, len(S), 2):
    if S[i] == '+':
        ans *= int(S[i+1])
    else:
        ans += int(S[i+1])
print ans
