S = raw_input()
w = int(raw_input())
ans = ''
for i in xrange(0, len(S), w):
    ans += S[i]
print ans
