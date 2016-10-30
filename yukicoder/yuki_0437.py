from itertools import combinations

S = raw_input()
N = len(S)

mem = {}
def rec(b):
    if b in mem:
        return mem[b]
    L = [i for i in xrange(N) if (1<<i) & b == 0]
    tmp_ans = 0
    for c, w1, w2 in combinations(L, 3):
        if S[c] != '0' and S[w1] == S[w2] and S[c] != S[w1]:
            tmp_ans = max(tmp_ans, rec(b + (1<<c) + (1<<w1) + (1<<w2)) + int(S[c]+S[w1]+S[w2]))
    mem[b] = tmp_ans
    return tmp_ans

print rec(0)

