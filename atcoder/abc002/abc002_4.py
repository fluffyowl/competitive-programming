# -*- coding:utf-8 -*-

import itertools

def input_to_int():
    return map(int, raw_input().split())

N, M = input_to_int()
relations = [[] for i in range(N+1)]
for i in range(M):
    x, y = input_to_int()
    relations[x].append(y)
    relations[y].append(x)

habatsu = 1
for i in range(2, N+1):
    for nodes in itertools.combinations(range(1, N+1), i):
        if all(map(lambda xy:xy[0] in relations[xy[1]], itertools.combinations(nodes,2))):
            habatsu = i
            break

print habatsu
