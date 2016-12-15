from collections import Counter
S = raw_input()
c = Counter(S)
if len(c.keys()) == 2:
    print 'Second'
    exit()
c[S[0]] -= 1
c[S[-1]] -= 1
if S[0] == S[-1]:
    print 'First' if sum(c.values()) % 2 == 0 else 'Second'
else:
    print 'First' if sum(c.values()) % 2 == 1 else 'Second'
