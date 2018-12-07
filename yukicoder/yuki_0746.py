N = input()
X = 10**N / 7
if N == 0:
    print 0
    exit()

ans = "0." + "0" * (N-1 - len(str(X))) + str(X)
print ans

