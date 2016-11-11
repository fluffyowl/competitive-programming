N = input()
ans = float('inf')
a = 1
while a*a*a <= N:
    if N%a > 0:
        a += 1
        continue
    b = 1
    while b*b <= N/a:
        if N/a%b > 0:
            b += 1
            continue
        c = N/a/b
        ans = min(a+b+c-3, ans)
        b += 1
    a += 1
print ans, N-1

