from math import log10

def solve():
    A, B = map(int, raw_input().split())
    x = B*log10(A)
    n = int(x)
    m = x-int(x)
    i = 10
    while log10(i/10.) <= m:
        i += 1
    i -= 1
    print str(i)[0], str(i)[1], n 

for _ in xrange(input()):
    solve()

