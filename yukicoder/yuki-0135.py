N = input()
X = sorted(set(map(int, raw_input().split())))
print min(X[i+1]-X[i] for i in xrange(len(X)-1)) if len(X)>1 else 0
