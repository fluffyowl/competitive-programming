while True:
    n = int(raw_input())
    if n == 0:
        break
    i = 2
    m = 2
    while i*i <= n:
        while n % i == 0:
            n /= i
            m = i
        i += 1
    print max(m, n)
