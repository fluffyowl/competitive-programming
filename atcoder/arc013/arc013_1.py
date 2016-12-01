from itertools import permutations
a = map(int, raw_input().split())
b = map(int, raw_input().split())
print max(reduce(lambda x,y:x*y, [a[i]/c[i] for i in range(3)]) for c in permutations(b))
