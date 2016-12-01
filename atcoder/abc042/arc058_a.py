N, K = map(int, raw_input().split())
D = raw_input().split()
while any(s in D for s in str(N)):
    N += 1
print N
