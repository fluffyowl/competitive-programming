N, M = map(int, raw_input().split())
A = map(int, raw_input().split())
C = range(N, 0, -1)

for a in A:
    C.append(C.pop(-a))
print C[-1]

