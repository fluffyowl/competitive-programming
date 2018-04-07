N = raw_input()
M = str(int(N[0])-1) + '9' * (len(N)-1)
print max(sum(map(int, list(N))), sum(map(int, list(M))))
