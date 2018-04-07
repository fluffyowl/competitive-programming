S = list(raw_input())
ans = 0
for s in S:
    ans = ans + int(s) if s != '0' else ans + 10
print ans
