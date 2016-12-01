n = input()
s = raw_input()
p = 0
ans = n
while p < n*2-1:
    if s[p] != s[p+1]:
        ans -= 1
        p += 2
    else:
        p += 1
print ans
