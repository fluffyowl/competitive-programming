while True:
    N, K = map(int, raw_input().split())
    if (N, K) == (0, 0):
        break
    print sum(sorted(map(int, raw_input().split()))[:K])
