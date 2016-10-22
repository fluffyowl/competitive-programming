S = raw_input()
M = input()
C = [raw_input() for _ in xrange(M)]
Ch = []
for s in C:
    h = 0
    for i, c in enumerate(s):
        h += 26**i*(ord(c)-ord('A')+1)
    Ch.append(h)

N = len(S)
rolling_hash = {}
for n in xrange(1, 11):
    if n > N:
        break
    h = 0
    for i in xrange(n):
        h += 26**i*(ord(S[i])-ord('A')+1)
    if h in rolling_hash:
        rolling_hash[h] += 1
    else:
        rolling_hash[h] = 1
    for i in xrange(n, N):
        h -= ord(S[i-n])-ord('A')+1
        h /= 26
        h += 26**(n-1)*(ord(S[i])-ord('A')+1) 
        if h in rolling_hash:
            rolling_hash[h] += 1
        else:
            rolling_hash[h] = 1

ans = 0            
for c in Ch:
    if c in rolling_hash:
        ans += rolling_hash[c]
print ans

