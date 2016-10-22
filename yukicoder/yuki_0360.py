from itertools import permutations
k = lambda a, b, c: (b<a<c or a<c<b)
print ['NO','YES'][any(all(k(L[i], L[i+1], L[i+2]) for i in xrange(5)) for L in permutations(map(int, raw_input().split())))]
