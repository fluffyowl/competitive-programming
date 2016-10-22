N = input()
D = map(int, raw_input().split())
done = 2**N-1

mem = {}
def rec(b, hp, maxhp):
    if (b, hp) in mem:
        return mem[(b, hp)]
    if b == done:
        return hp
    m = 0
    for i in xrange(N):
        if (1<<i) & b:
            continue
        if D[i] > 0:
            m = max(m, rec(b+(1<<i), min(hp+D[i], maxhp), maxhp))
        elif hp + D[i] > 0:
            m = max(m, rec(b+(1<<i), hp+D[i], maxhp+100))

    mem[(b, hp)] = m
    return m

print rec(0, 100, 100)

