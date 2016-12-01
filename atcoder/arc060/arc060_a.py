N, A = map(int, raw_input().split())
a = sorted(map(lambda x:int(x)-A, raw_input().split()))
mem = {}

def rec(p, acm):
    if (p, acm) in mem:
        return mem[(p, acm)]
    if p >= N:
        return 0
    if a[p] > 0 and acm > 0:
        return 0
    mem[(p, acm)] = rec(p+1, acm+a[p]) + rec(p+1, acm)
    if acm+a[p] == 0:
        mem[(p, acm)] += 1
    return mem[(p, acm)]

print rec(0, 0)
