s = raw_input()
g = 'oda' if s == 'yukiko' else 'yukiko'
n = sum(raw_input().count('.') for _ in xrange(8))
print g if n%2 else s
