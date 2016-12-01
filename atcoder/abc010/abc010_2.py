N = int(raw_input())
a = map(int, raw_input().split())

s = 0
for n in a:
    m = n % 6
    if m == 0:
        s += 3
    elif m == 2:
        s += 1
    elif m == 4:
        s += 1
    elif m == 5:
        s += 2
print s
