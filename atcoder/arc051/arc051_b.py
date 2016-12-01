K = int(raw_input())
c = 0
a, b = 1, 1
while c < K:
    c += 1
    a, b = a+b, a
print a, b
