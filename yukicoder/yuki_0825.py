A, B, C = map(int, input().split())

for i in range(1, A + 10 * B + 1):
    for a in range(A+1):
        for b in range(B+1):
            if a + 10 * b < i:
                continue
            c = a + 10 * b - i
            c = c % 10 + c // 10 + A - a + B - b
            if c == C:
                print(i)
                exit()
print ("Impossible")
