n = raw_input()
for i in range(input()):
    r = raw_input().split()
    if r[0] == n:
        n = r[1]
    elif r[1] == n:
        n = r[0]
print n
