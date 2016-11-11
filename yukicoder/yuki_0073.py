import string

ans = 1
for i, c in enumerate(string.ascii_lowercase):
    n = int(raw_input())
    if c in 'hewrd':
        ans *= n
    elif c == 'o':
        ans *= (n/2+n%2) * (n/2)
    elif c == 'l':
        m = 0
        for i in xrange(2, n):
            m = max(m, i*(i-1)/2*(n-i))
        ans *= m
print ans

