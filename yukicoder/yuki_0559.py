S = raw_input()
ans = 0
for i in xrange(len(S)):
    if S[i] == 'A':
        continue
    for j in xrange(i+1, len(S)):
        if S[j] == 'A':
            ans += 1
print ans

