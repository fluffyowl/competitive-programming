N = input()
p = sorted(map(int, raw_input().split()))
mem = {}

def rec(i, a):
    if (i, a) in mem:
        return mem[(i, a)]
    if a == 0:
        return True
    if i >= N:
        return False
    if a < p[i]:
        return False
    mem[(i, a)] = rec(i+1, a) or rec(i+1, a-p[i])
    return mem[(i, a)]

ans = 0
for i in xrange(sum(p)+1):
    ans += rec(0, i)
print ans
