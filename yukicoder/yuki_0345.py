S = raw_input()
ans = float('inf')
for i in xrange(len(S)):
    if S[i] != 'c':
        continue
    w = 0
    for j in xrange(i+1, len(S)):
        if S[j] == 'w':
            w += 1
            if w == 2:
                ans = min(ans, j-i+1)
                break
print ans if ans != float('inf') else -1

