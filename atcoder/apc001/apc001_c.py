import sys


def ask(n):
    print n
    sys.stdout.flush()
    ans = raw_input()
    if ans == 'Female':
        return 0
    elif ans == 'Male':
        return 1
    else:
        exit()


N = input()
x = ask(0)
l = 1
r = N-1
lx = x
rx = x

while True:
    m = (l + r) / 2
    x = ask(m)
    if (m - l + 1) % 2 == 0 and lx != x:
        r = m - 1
        rx = x
    elif (m - l + 1) % 2 == 1 and lx == x:
        r = m - 1
        rx = x
    elif (r - m + 1) % 2 == 0 and rx != x:
        l = m + 1
        lx = x
    elif (r - m + 1) % 2 == 1 and rx == x:
        l = m + 1
        lx = x
    else:
        r = m - 1
        rx = x
