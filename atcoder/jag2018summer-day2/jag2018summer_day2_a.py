X, Y, Z = map(int, raw_input().split())
c = Z

while True:
    if c % 17 == X and c % 107 == Y:
        print c
        exit()
    c += 10**9 + 7
