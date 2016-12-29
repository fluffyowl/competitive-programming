N = input()
T = map(int, raw_input().split())
S = sum(T)
M = input()
for i in xrange(M):
    p, x = map(int, raw_input().split())
    print S + x - T[p-1]
