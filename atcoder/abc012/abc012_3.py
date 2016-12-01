N = int(raw_input())
product = 2025 - N
for i in range(1, 10):
    for j in range(1, 10):
        if i * j == product:
            print i, 'x', j
