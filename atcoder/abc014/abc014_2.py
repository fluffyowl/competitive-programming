n, X = map(int, raw_input().split())
prices = map(int, raw_input().split())

X = format(X, 'b')[::-1]
s = 0
for i in range(len(X)):
    if X[i] == '1':
        s += prices[i]
print s
