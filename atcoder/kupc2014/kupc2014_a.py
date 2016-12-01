from itertools import permutations

a = map(int, raw_input().split())
print min(abs(a[0]-a[3+i]) + abs(a[1]-a[3+j]) + abs(a[2]-a[3+k]) for i, j, k in permutations((0,1,2)))
