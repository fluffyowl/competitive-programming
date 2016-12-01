W=raw_input()
d={k:0 for k in list('ABCDEF')}
for c in W:
    d[c] += 1
for c in list('ABCDEF'):
    print d[c],
print
