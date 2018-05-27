N = input()
N = 10**N
S = set()
for i in xrange(70):
    for j in xrange(70):
        a = 2**i * 5**j
        if N % a == 0:
            S.add(a)
S = sorted(list(S))
for s in S:
    print s

