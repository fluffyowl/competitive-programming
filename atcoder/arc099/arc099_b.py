from fractions import Fraction

def calc(a):
    return sum(map(int, list(str(a))))

def comp(a, b):
    return a * calc(b) <= b * calc(a)

MAX = 10**17
K = input()
A = set()
base = 0
front = 1
ok = True
while base < MAX:
    for i in xrange(1, 999):
        tmp = i * front + base
        if tmp <= MAX:
            A.add(tmp)
    base = base * 10 + 9
    front *= 10

A = sorted(list(A), key=lambda x: -x)
m = A[0]
ans = []

for i in xrange(1, len(A)):
    if comp(A[i], m):
        m = A[i]
        ans.append(A[i])

ans.sort()
for i in xrange(K):
    print ans[i]
