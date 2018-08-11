from collections import Counter

N = input()
S = [None for _ in xrange(21)]
for _ in xrange(N):
    Q = raw_input().split()
    if Q[0] == '0':
        n, m = map(int, Q[1:3])
        S[n] = Counter(Q[3:])
    elif Q[0] == '1':
        b = Q[1]
        ok = False
        for i in xrange(1, 21):
            if S[i] is None:
                continue
            if b in S[i] and S[i][b] > 0:
                print i
                S[i][b] -= 1
                ok = True
                break
        if not ok:
            print -1
    else:
        i = int(Q[1])
        S[i] = None

