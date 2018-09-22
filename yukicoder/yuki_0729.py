S = list(raw_input())
i, j = map(int, raw_input().split())
S[i], S[j] = S[j], S[i]
print ''.join(S)

