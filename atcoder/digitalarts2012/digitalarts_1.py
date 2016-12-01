import re
S = raw_input().split()
for i in xrange(input()):
    f = raw_input().replace('*', '.')
    lenf = len(f)
    pattern = re.compile(f)
    kome = '*'*lenf
    for i, s in enumerate(S):
        if len(s) == lenf and pattern.match(s):
            S[i] = kome
print ' '.join(S)
