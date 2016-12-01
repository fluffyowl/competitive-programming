n = input()
a = sorted(zip(map(int, raw_input().split()), range(1, n+1)), reverse=True)
for b in a:
    print b[1]
