from collections import Counter

A = set(list("abcdefghijklm"))
S = raw_input()
if len(set(S) - A) > 0:
    print "Impossible"
    exit()

C = Counter(S)
if sorted(C.values()) == [1 for _ in xrange(13)]:
    for i in sorted(list(A)):
        print i
elif sorted(C.values()) == [1] * 11 + [2]:
    for i in A:
        if i not in C.keys():
            print i
else:
    print "Impossible"

