A, B, C = map(int, raw_input().split())
A = A * 60
C = C * 3600

if A <= B:
    print -1
    exit()

print (C - 1) / (A - B) + 1

