S = raw_input()
left = 0
ans = 0
for s in S:
    if s == 'S':
        left += 1
    elif s == 'T' and left > 0:
        left -= 1
        ans += 2
print len(S) - ans
