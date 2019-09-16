from itertools import permutations

x, y, z = map(int, input().split())

s0, t0 = input().split()
s1, t1 = input().split()
t0 = int(t0) - 1
t1 = int(t1) - 1

D = {}
D['A'] = x - 1
D['B'] = y - 1
D['C'] = z - 1

A = [('A', 0), ('A', x-1), ('B', 0), ('B', y-1), ('C', 0), ('C', z-1), (s0, t0), (s1, t1)]
A = list(set(A))
B = {}

for a in A:
    B[a] = {}
    for b in A:
        if a[0] == b[0]:
            B[a][b] = abs(a[1] - b[1])
        else:
            B[a][b] = min(a[1] + b[1] + 1 , D[a[0]] - a[1] + D[b[0]] - b[1] + 1)

for a in A:
    for b in A:
        for c in A:
            B[b][c] = min(B[b][c], B[b][a] + B[a][c])

print(B[s0, t0][s1, t1])

