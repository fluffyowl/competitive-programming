from fractions import gcd

N = raw_input()
S = set(N)

if len(S) == 1:
    print N
    exit()

g = reduce(gcd, [abs(9*(int(a)-int(b))) for a in S for b in S if a != b])
print max(i for i in xrange(1, g+1) if g%i == 0 and int(N)%i == 0)

