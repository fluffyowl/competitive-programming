from collections import Counter
S = Counter(list(raw_input()))

one = -1
for k in S.keys():
    if S[k] == 1:
        one = k
        break

if one == -1:
    print "Impossible"
    exit()

print one if all(S[k] == 2 for k in S.keys() if k != one) else "Impossible"

