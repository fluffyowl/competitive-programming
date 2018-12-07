N, K = map(int, raw_input().split())

if K % 2 == 1:
    print (N / K) ** 3
else:
    x = N / K
    y = N / K + (N % K >= K / 2)
    print x ** 3 + y ** 3
