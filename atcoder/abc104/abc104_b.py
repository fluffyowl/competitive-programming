from collections import Counter

S = raw_input()
ok1 =  S[0] == 'A'
c = Counter(S[2:len(S)-1])
ok2 = ('C' in c) and (c['C'] == 1)
c = Counter(S[1:])
ok3 = True
if 'C' in c and c['C'] > 1:
    ok3 = False
for cc in c.keys():
    if cc != 'C' and cc.isupper():
        ok3 = False
print "AC" if ok1 and ok2 and ok3 else "WA"
