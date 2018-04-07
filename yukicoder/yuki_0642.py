N = input()
ans = 0

while N != 1:
    if N % 2 == 0:
        N /= 2
    else:
        N += 1
    ans += 1

print ans

