S = 0
for i in range(3):
    s, e = map(int, raw_input().split())
    S += s/10 * e
print S
