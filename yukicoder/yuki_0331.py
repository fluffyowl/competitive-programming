import sys

sys.setrecursionlimit(10000)

def communicate(S):
    print S
    sys.stdout.flush()
    T = raw_input()
    if T == '20151224':
        goal()
    return int(T) if T.isdigit() else T

def goal():
    print 'F'
    sys.stdout.flush()
    S = raw_input()
    while S != "Merry Christmas!":
        print 'F'
        sys.stdout.flush()
        S = raw_input()
    exit()

MAX = 20151224
visited = set()
dxdy = [(0, -1), (1, 0), (0, 1), (-1, 0)]
d = 0

def dfs(x, y, d, n):
    if n == MAX:
        goal()
    visited.add((x, y))
    if n > 0:
        dfs(x+dxdy[d][0], y+dxdy[d][1], d, communicate('F'))
    n = communicate('R')
    d = (d+1)%4
    if n > 0 and (x+dxdy[d][0], y+dxdy[d][1]) not in visited:
        dfs(x+dxdy[d][0], y+dxdy[d][1], d, communicate('F'))
    communicate('R')
    n = communicate('R')
    d = (d+2)%4
    if n > 0 and (x+dxdy[d][0], y+dxdy[d][1]) not in visited:
        dfs(x+dxdy[d][0], y+dxdy[d][1], d, communicate('F'))
    communicate('R')
    d = (d+1)%4
    communicate('B')
    return

dfs(0, 0, 0, int(raw_input()))
communicate('F')
communicate('R')
n = communicate('R')
dfs(0, 0, 2, n)

