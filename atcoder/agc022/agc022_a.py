from string import ascii_lowercase

S = raw_input()
if S == "zyxwvutsrqponmlkjihgfedcba":
    print -1
elif len(S) == 26:
    S = [ascii_lowercase.index(s) for s in S]
    while True:
        S[-1] += 1
        if S[-1] >= 26:
            S.pop()
        elif len(set(S)) == len(S):
            break
    print ''.join([ascii_lowercase[i] for i in S])
else:
    for a in ascii_lowercase:
        if a not in S:
            print S + a
            break
