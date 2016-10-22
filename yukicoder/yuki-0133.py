from itertools import permutations
N = input()
A = map(int, raw_input().split())
B = map(int, raw_input().split())
ans = 0
for a in permutations(A):
    for b in permutations(B):
        if sum(c>d for c,d in zip(a,b)) > sum(d>c for c,d in zip(a,b)):
            ans += 1
print ans/reduce(lambda x,y:x*y, range(1, N+1), 1.0)**2

