N, A, B = map(int, raw_input().split())
i = 0
d = [A, B]
while N > 0:
    N -= d[i%2]
    i += 1
print ['Bug', 'Ant'][i%2]
