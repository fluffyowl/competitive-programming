from itertools import combinations 
F = [3,5,17,257,65537]
N = input()
ans = 0
for m in xrange(30):
    for i in xrange(6):
        for comb in combinations(F, i):
            if 3<= reduce(lambda a, b:a*b, comb, 2**m) <= N:
                ans += 1
print ans

