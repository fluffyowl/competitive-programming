from itertools import product

N = input()
league = [list(raw_input()) for _ in xrange(N)]

unfixed = []
for i in xrange(N):
    for j in xrange(i+1, N):
        if league[i][j] == '-':
            unfixed.append((i, j))

if len(unfixed) == 0:
    rank = sorted(set(map(lambda x:x.count('o'), league)), reverse=True)
    print rank.index(league[0].count('o'))+1
    exit()
ans = N+1
for ox in product('ox', repeat=len(unfixed)):
    for k in xrange(len(unfixed)):
        i, j = unfixed[k]
        league[i][j] = ox[k]
        league[j][i] = 'o' if ox[k] == 'x' else 'x'
    rank = sorted(set(map(lambda x:x.count('o'), league)), reverse=True)
    ans = min(ans, rank.index(league[0].count('o'))+1)

print ans

