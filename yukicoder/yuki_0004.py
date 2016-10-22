N = input()
w = sorted(map(int, raw_input().split()))
s = sum(w)

if s % 2:
    print 'impossible'
    exit()

s /= 2
mem = {}
def rec(p, acm):
    if (p, acm) in mem:
        return mem[(p, acm)]

    if acm == s:
        return True
    if p >= N:
        return False
    if w[p] + acm > s:
        return False

    mem[(p, acm)] = any((rec(p+1, acm+w[p]), rec(p+1, acm)))
    return mem[(p, acm)]

print 'possible' if rec(0, 0) else 'impossible'

