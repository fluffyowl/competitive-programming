N = input()

F = [1, 1]
while F[-1] + F[-2] <= N:
    F.append(F[-1]+F[-2])

ans = 0
i = len(F)-1
while N > 0:
    while N >= F[i]:
        N -= F[i]
        ans += 1
    i -= 1

print ans
