S = raw_input()
m = float('-inf')
for i in xrange(len(S)):
    s = (S[i:] + S[:i])
    if s[0] in '+-' or s[-1] in '+-':
        continue
    m = max(m, sum(map(int, s.replace('-', '+-').split('+'))))
print m

