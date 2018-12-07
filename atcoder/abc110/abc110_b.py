N, M, X, Y = map(int, raw_input().split())
A = map(int, raw_input().split())
B = map(int, raw_input().split())
a = max(A)
b = min(B)

for i in xrange(-110, 110):
    if a < i <= b and X < i <= Y:
        print "No War"
        exit()
print "War"
