def eq(x, y):
    return x - y == 0

def gr(x, y):
    z = x - y
    return abs(z) == z

N = input()
for _ in xrange(N):
    a, b = map(int, raw_input().split())
    if eq(a, b):
        print '='
    elif gr(a, b):
        print chr(62)
    else:
        print chr(60)

