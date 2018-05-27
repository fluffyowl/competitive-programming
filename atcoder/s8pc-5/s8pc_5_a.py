N, T = map(int, raw_input().split())
A = map(int, raw_input().split())

x = 0
for a in A:
    if x - a <= 0:
        k = 0
    else:
        k = (x - a) / T
        k += ((x - a) % T != 0)
    x = a + k * T
print x
