N, A, B = map(int, raw_input().split())
p = 0

for i in range(N):
    s, d = raw_input().split()
    d = int(d)
    if d < A:
       p = p+A if s == 'East' else p-A
    elif d > B:
        p = p+B if s == 'East' else p-B
    else:
        p = p+d if s == 'East' else p-d

if p > 0:
    print 'East', p
elif p < 0:
    print 'West', abs(p)
else:
    print 0
