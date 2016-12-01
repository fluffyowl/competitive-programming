s = raw_input()
t = raw_input()
atcoder = set(list('atcoder@'))
for i in range(len(s)):
    if s[i] == t[i]:
        continue
    if s[i] == '@' and t[i] in atcoder:
        continue
    if t[i] == '@' and s[i] in atcoder:
        continue
    print 'You will lose'
    break
else:
    print 'You can win'
