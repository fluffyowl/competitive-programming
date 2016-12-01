N, Q = map(int, raw_input().split())
possible = [False for _ in xrange(N)]
possible[0] = True
possible[1] = True
A = 0

for q in xrange(Q):
    a, b = map(lambda x:int(x)-1, raw_input().split())
    if a == A:
        A = b
    elif b == A:
        A = a
    possible[a], possible[b] = possible[b], possible[a]
    possible[max(0, A-1)] = True
    possible[min(N-1, A+1)] = True

print sum(possible)
