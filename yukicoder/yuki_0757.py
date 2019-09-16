B = int(raw_input())
D = int(raw_input(), base=B)

def f(n):
    if n == 0:
        return 0
    else:
        return n * B ** n - (B ** n - 1) / (B - 1)

def solve1():
    hi = 10**5
    lo = 0
    while hi - lo > 1:
        mid = (hi + lo) / 2
        if f(mid) >= D:
            hi = mid
        else:
            lo = mid
    return hi

def solve2():
    keta = solve1()
    x = f(keta-1)
    a = B ** (keta-1)
    hi = (D - x) / keta + ((D - x) % keta > 0)
    lo = hi - 1
    x += lo * keta
    hi += a - 1
    return hi / (B ** (keta - D + x)) % B

print solve2()
