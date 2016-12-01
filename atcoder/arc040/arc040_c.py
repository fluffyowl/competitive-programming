N = int(raw_input())
S = []
for i in range(N):
    S.append(list(raw_input()))
S.append(['o']*N)
ans = 0
for i in range(N):
    for j in xrange(N-1, -1, -1):
        if S[i][j] == '.':
            last = j
            break
    else:
        continue
    S[i+1][j:] = ['o'] * (N-j) 
    ans += 1
print ans
