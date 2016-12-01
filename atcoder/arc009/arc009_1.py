s = 0
for i in range(input()):
    a, b = map(int, raw_input().split())
    s += a*b
print int(s*1.05)
