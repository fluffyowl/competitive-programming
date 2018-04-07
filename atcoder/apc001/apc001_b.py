N = input()
A = map(int, raw_input().split())
B = map(int, raw_input().split())
x = 0

for a, b in zip(A, B):
    if a >= b:
        x -= a - b
    else:
        x += (b - a) / 2

print 'Yes' if x >= 0 else "No"
