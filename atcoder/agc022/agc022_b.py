from fractions import gcd

def check(A):
    g = reduce(gcd, A)
    if g != 1:
        return False
    s = sum(A)
    for a in A:
        if gcd(a, s - a) == 1:
            print a, s - a, gcd(a, s - a)

N = input()
M = 30000

if N == 3:
    print "2 5 63"
elif N == 4:
    print "2 5 20 63"
elif N == 5:
    print "2 3 4 9 12"
else:
    ans = [2, 4, 3, 9]
    a = 8
    b = 6
    c = 15
    while len(ans) < N:
        if N - len(ans) == 1:
            ans.append(b)
        elif a + 2 <= M:
            ans.append(a)
            ans.append(a+2)
            a += 6
        elif c + 6 <= M:
            ans.append(c)
            ans.append(c+6)
            c += 12
        else:
            ans.append(b)
            b += 6
    print ' '.join(map(str, ans))
