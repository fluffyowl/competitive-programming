N = int(raw_input())
S = []
for i in range(N):
    S.append(int(raw_input()))

summation = sum(S)
knowing = [[False for i in range(N)] for j in range(N)]
for i in range(N):
    knowing[i][i] = True
    
M = int(raw_input())
for i in range(M):
    a, b, c = map(int, raw_input().split())
    b, c = b-1, c-1
    if a == 0:
        knowing[b][c] = True
        continue
    if knowing[b][c]:
        print S[c], S[c]
        continue
    nokori = summation - sum([S[j] for j in range(N) if knowing[b][j]])
    kagen = max(0, nokori - (N - sum(knowing[b]) - 1)*100)
    jogen = min(100, nokori)
    print kagen, jogen
