K = input()

if K == 0:
    print 1
    print 0
    exit()

A = [1, 1]
x = 2
S = set()
for i in xrange(60):
    S.add(2**i)

while True:
    y = x * (x - 1) / 2
    if K % y == 0 and K / y in S:
        K /= y
        break
    A.append(1)
    x += 1

while K > 1:
    A.append(0)
    K /= 2

print len(A)
print ' '.join(map(str, A))

