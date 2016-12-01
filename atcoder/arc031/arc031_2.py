grid = [['x']+list(raw_input())+['x'] for i in range(10)]
grid.insert(0, ['x']*12)
grid.append(['x']*12)

def dfs(i, j):
    result = set()
    stack = [(i, j)]
    while len(stack) != 0:
        a, b = stack.pop()
        result.add((a, b))
        if grid[a-1][b] == 'o' and (a-1, b) not in result:
            stack.append((a-1, b))
        if grid[a+1][b] == 'o' and (a+1, b) not in result:
            stack.append((a+1, b))
        if grid[a][b-1] == 'o' and (a, b-1) not in result:
            stack.append((a, b-1))
        if grid[a][b+1] == 'o' and (a, b+1) not in result:
            stack.append((a, b+1))
    return result

sets = []
for i in range(1, 11):
    for j in range(1, 11):
        if grid[i][j] == 'x':
            continue
        if any((i, j) in s for s in sets):
            continue
        sets.append(dfs(i, j))

for i in range(1, 11):
    for j in range(1, 11):
        if grid[i][j] == 'o':
            continue
        if all(any(abs(a-i)+abs(b-j)==1 for a, b in s) for s in sets):
            print 'YES'
            exit()

print 'NO'
