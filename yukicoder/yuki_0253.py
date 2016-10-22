import sys

def ask(n):
    print '?', n
    sys.stdout.flush()
    return int(raw_input())

def ans(n):
    print '!', n
    sys.stdout.flush()
    exit()

res = ask(100)
if res == 0:
    ans(100)
high = 100 if res < 0 else 10**9
low = 0
i = 1

while high - low > 1:
    mid = (high+low)/2
    res = ask(mid-i)
    if res == 0:
        ans(mid)
    if res > 0:
        low = mid
    else:
        high = mid
    i += 1

res = ask(low-i)
if res == 0:
    ans(low)
else:
    ans(high)

