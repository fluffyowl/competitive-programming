def find(table, x):
    t = []
    while table[x] >= 0:
        t.append(x)
        x = table[x]
    for s in t:
        table[s] = x
    return x

def union(table, x, y):
    x = find(table, x)
    y = find(table, y)
    if x == y:
        return table
    if table[x] <= table[y]:
        table[y] += table[x]
        table[x] = y
    else:
        table[x] += table[y]
        table[y] = x
    return table

N, M = map(int, raw_input().split())
table = [-1 for i in range(N)]
for i in range(M):
    a, b = map(lambda x:int(x)-1, raw_input().split())
    table = union(table, a, b)
print len([x for x in table if x < 0])-1
