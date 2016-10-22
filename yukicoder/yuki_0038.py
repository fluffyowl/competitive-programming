Kr, Kb = map(int, raw_input().split())
S = raw_input()
C = S.count('R') + S.count('B')

def solve(b):
    newS = ''
    c = -1
    for i, s in enumerate(S):
        if s != 'W':
            c += 1
            if ((1<<c) & b):
                continue
        newS += s
    N = len(newS)
    for i in xrange(N-Kr):
        if newS[i] == 'R' and newS[i+Kr] == 'R':
            return 0
    for i in xrange(N-Kb):
        if newS[i] == 'B' and newS[i+Kb] == 'B':
            return 0
    return N

ans = S.count('W')
for b in xrange(1<<C):
    ans = max(solve(b), ans)
print ans

