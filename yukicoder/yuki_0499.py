N = input()
ans = 0
a = 1
i = 0
while a * 7 <= 10**9:
    a *= 7
    i += 1

while a > 0:
    ans += N / a * (10**i)
    N -= N / a * a
    a /= 7
    i -= 1

print ans

