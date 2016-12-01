import itertools

N, K = map(int, raw_input().split())
opts = []
for i in range(N):
    opts.append(map(int, raw_input().split()))

xor = lambda a, b: a^b
for opt in itertools.product(*opts):
    if reduce(xor, opt) == 0:
        print 'Found'
        exit()
print 'Nothing'
