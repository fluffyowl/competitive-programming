N = int(raw_input())
a, b = raw_input().split()
K = int(raw_input())
P = raw_input().split()

L = len(P) + 2
sP = set(P+[a, b])

if L == len(sP):
    print 'YES'
else:
    print 'NO'
