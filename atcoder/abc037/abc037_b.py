def input_to_int():
    return map(int, raw_input().split())

N, Q = input_to_int()
op = [0 for i in range(N)]
for i in range(Q):
    L, R, T = input_to_int()
    for j in range(L-1, R):
        op[j] = T

for i in op:
    print i
