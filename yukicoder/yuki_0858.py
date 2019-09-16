a, b = map(int, input().split())
x = str(a // b)+'.'
y = a % b * 10
for _ in range(50):
    x += str(y // b)
    y = (y % b) * 10
print(x)

