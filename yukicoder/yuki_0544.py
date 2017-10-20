N = raw_input()
xx = [0 for _ in xrange(len(N))]
for i, n in enumerate(N):
    if n == '7':
        xx[i] = 1
x = int(''.join(map(str, xx)))
print int(N) - x, x

