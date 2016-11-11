A, B = map(int, raw_input().split())
ans = float('inf')
for a in xrange(1000):
    for b in xrange(1000):
        if a == b == 0:
            continue
        Aa = round(float((100*a))/(a+b))
        Bb = round(float((100*b))/(a+b))
        if Aa == A and Bb == B:
            ans = min(ans, a+b)
print ans

