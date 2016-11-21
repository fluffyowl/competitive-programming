N = int(raw_input())
ans = 0
d = 0
for y in xrange(2015, min(2415, N)):
    if y % 400 == 0:
        d += 2
    elif y % 100 == 0:
        d += 1
    elif y % 4 == 0:
        d += 2
    else:
        d += 1
    if d % 7 == 0:
        ans += 1

if N < 2415:
    print ans
    exit()

ans *= (N-2014) / 400
d = 0
for y in xrange(2014 + (N-2014) / 400 * 400 + 1, N+1):
    if y % 400 == 0:
        d += 2
    elif y % 100 == 0:
        d += 1
    elif y % 4 == 0:
        d += 2
    else:
        d += 1
    if d % 7 == 0:
        ans += 1
print ans

