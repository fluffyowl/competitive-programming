def input_to_int():
    return map(int, raw_input().split())

L, X, Y, S, D = input_to_int()
if S > D:
    if Y <= X:
        print float(D-S+L)/(X+Y)
    else:
        print min(float(D-S+L)/(X+Y), float(S-D)/(Y-X))
elif S < D:
    if Y <= X:
        print float(D-S)/(X+Y)
    else:
        print min(float(D-S)/(X+Y), float(S-D+L)/(Y-X))
else:
    print 0
