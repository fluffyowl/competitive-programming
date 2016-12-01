import math
A, B, C = map(int, raw_input().split())

def f(t):
    return A*t + B*math.sin(C*math.pi*t)

start = 0.5/C
n = 1
while f(start*n) < 100:
    n += 1
t = start*n
upper = min(t, 100.0)
lower = max(0, t-(0.5/C))

EPS = 0.0000000001
while upper - lower > EPS:
    middle = (upper + lower)/2.0
    if f(middle) >= 100:
        upper = middle
    else:
        lower = middle

print upper
