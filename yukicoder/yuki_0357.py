N, M = map(int, raw_input().split())
score = [[0 for j in xrange(N)] for i in xrange(N)]
for _ in xrange(M):
    i1, i2, s = map(int, raw_input().split())
    score[i1-1][i2-1] = s

mem = {}
def rec(p, b):
    if (p, b) in mem:
        return mem[(p, b)]
    ret = sum(score[i][p] for i in xrange(N) if (1<<i) & b)
    orig_ret = ret
    for i in xrange(N):
        if not ((1 << i) & b):
            ret = max(ret, rec(i, b+(1<<i))+orig_ret)
    mem[(p, b)] = ret
    return ret

print max(rec(i, 1<<i) for i in xrange(N))
    

