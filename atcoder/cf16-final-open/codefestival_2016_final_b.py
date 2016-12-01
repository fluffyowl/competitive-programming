N = input()
i = 1
while i*(i+1)/2 < N:
    i += 1

print i

N -= i
j = i-1
while N > 0:
    if N - j >= 0:
        print j
        N -= j
    j -= 1
