N = input()
S = raw_input()

x = 0
ans = 0
for s in S:
    if s == 'I':
        x += 1
        ans = max(ans, x)
    else:
        x -= 1
print ans
