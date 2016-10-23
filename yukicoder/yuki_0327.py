N = input()
ans = chr(ord('A')+N%26)
i = 1
while N >= 26**i:
    m = sum(26**i for i in xrange(1, i+1))
    if N-m < 0:
        break
    ans += chr(ord('A')+((N-m)/26**i)%26)
    i += 1
print ans[::-1]
