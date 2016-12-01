from itertools import combinations
def input_to_int():
    return map(int, raw_input().split())
L = input_to_int()
M = []
for x, y, z in combinations(L, 3):
    M.append(x+y+z)
print sorted(M)[-3]
