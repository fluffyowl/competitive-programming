a, b, c = map(int, input().split())
if c < a:
    print(c)
elif c < b:
    print(c-1)
else:
    print(c-2)

