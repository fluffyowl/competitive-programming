import itertools
N = int(raw_input())
for s in itertools.product('abc', repeat=N):
    print ''.join(s)
