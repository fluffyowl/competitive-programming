S = raw_input()[::-1]
ans = []
detenai = set('ABCDEFGH')
for s in S:
    if s in detenai:
        ans.append(s)
        detenai.remove(s)
print ''.join(list(detenai)+ans[::-1])
