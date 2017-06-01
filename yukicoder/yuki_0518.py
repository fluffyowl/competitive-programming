N = input()
R = raw_input().split()


def parse(r):
    n = len(r)
    p = 0
    ans = 0
    while p < n:
        if r[p:].startswith('IV'):
            ans += 4
            p += 2
        elif r[p:].startswith('IX'):
            ans += 9
            p += 2
        elif r[p:].startswith('XL'):
            ans += 40
            p += 2
        elif r[p:].startswith('XC'):
            ans += 90
            p += 2
        elif r[p:].startswith('CD'):
            ans += 400
            p += 2
        elif r[p:].startswith('CM'):
            ans += 900
            p += 2
        elif r[p:].startswith('I'):
            ans += 1
            p += 1
        elif r[p:].startswith('V'):
            ans += 5
            p += 1
        elif r[p:].startswith('X'):
            ans += 10
            p += 1
        elif r[p:].startswith('L'):
            ans += 50
            p += 1
        elif r[p:].startswith('C'):
            ans += 100
            p += 1
        elif r[p:].startswith('D'):
            ans += 500
            p += 1
        elif r[p:].startswith('M'):
            ans += 1000
            p += 1
    return ans

def rev(n):
    ans = ''
    x = n / 1000
    for i in xrange(x):
        ans += 'M'

    n -= x * 1000
    x = n / 100

    if x == 9:
        ans += 'CM'
    elif x >= 5:
        ans += 'D'
        for i in xrange(x-5):
            ans += 'C'
    elif x == 4:
        ans += 'CD'
    else:
        for i in xrange(x):
            ans += 'C'

    n -= x * 100
    x = n / 10

    if x == 9:
        ans += 'XC'
    elif x >= 5:
        ans += 'L'
        for i in xrange(x-5):
            ans += 'X'
    elif x == 4:
        ans += 'XL'
    else:
        for i in xrange(x):
            ans += 'X'

    n -= x * 10
    x = n

    if x == 9:
        ans += 'IX'
    elif x >= 5:
        ans += 'V'
        for i in xrange(x-5):
            ans += 'I'
    elif x == 4:
        ans += 'IV'
    else:
        for i in xrange(x):
            ans += 'I'
    return ans


hoge = 0
for r in R:
    hoge += parse(r)
print rev(hoge) if hoge < 4000 else "ERROR"

