yeah = 'YEAH!'
S = raw_input()
ans = []
for c in yeah:
    ans.append(S.count(c))
print ' '.join(map(str, ans))

