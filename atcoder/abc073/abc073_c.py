N = input()
S = set()
for i in xrange(N):
    a = int(raw_input())
    if a in S:
        S.discard(a)
    else:
        S.add(a)
print len(S)
