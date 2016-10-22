import sys
sys.setrecursionlimit(10000)

N = input()
V = map(int, raw_input().split())
mem = [0 for i in xrange(N)]

def rec(n):
    if n >= N:
        return 0
    if mem[n] > 0:
        return mem[n]
    mem[n] = max(rec(n+1), rec(n+2)+V[n])
    return mem[n]

print rec(0)

