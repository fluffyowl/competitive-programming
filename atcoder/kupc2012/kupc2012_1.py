N, T, E = map(int, raw_input().split())
X = map(int, raw_input().split())
L = T-E
R = T+E

for i, x in enumerate(X):
    y = x
    while y <= R:
        if y >= L:
            print i+1
            exit()
        y += x
print -1
