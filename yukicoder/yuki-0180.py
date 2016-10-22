N = input()
ab = [map(int, raw_input().split()) for _ in xrange(N)]
def f(x):
    new_ab = map(lambda y:y[0]+y[1]*x, ab)
    return max(new_ab) - min(new_ab)

left = 1
right = 10**9

while right - left > 2:
    unit = (right-left)/3
    if f(right-unit) >= f(left+unit):
        right = right-unit
    else:
        left = left+unit
print min(range(left, right+1), key=lambda x:f(x))
