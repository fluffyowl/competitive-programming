N = int(raw_input())
ss = [list('.'*9)]
ans = 0
for i in range(N):
    s = list(raw_input())
    for j in range(9):
        if s[j] == 'x':
            ans += 1
        elif s[j] == 'o' and ss[-1][j] != 'o':
            ans += 1
    ss.append(s)
print ans
