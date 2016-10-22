N = input()
a = ord('A') - 10
def f(s):
    d = max(s)
    d = int(d)+1 if d.isdigit() else ord(d)-a+1
    x = 0
    for i, c in enumerate(s[::-1]):
        x += int(c)*(d**i) if c.isdigit() else (ord(c)-a)*(d**i)
    return x
print min(map(f, [raw_input() for _ in xrange(N)]))

