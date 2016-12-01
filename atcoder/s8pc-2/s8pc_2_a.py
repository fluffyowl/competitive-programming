S = raw_input()

ans = 0
mode = 'I'
for i in range(len(S)):
    if mode == S[i]:
        ans += 1
        mode = 'I' if mode == 'O' else 'O'
print ans if mode == 'O' or ans == 0 else ans-1
