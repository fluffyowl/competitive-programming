import sys

def kagi(num):
    print num
    sys.stdout.flush()
    result = int(raw_input().split()[0])
    if result == 10:
        exit()
    return result

baseline = kagi('0000000000')

ans = ['0' for i in xrange(10)]
for i in xrange(1, 10):
    for j in xrange(10):
        k = ['0' for _ in xrange(10)]
        k[j] = str(i)
        n = kagi(''.join(k))
        if n > baseline:
            ans[j] = str(i)

kagi(''.join(ans))

