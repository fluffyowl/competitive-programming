N = input()
t, a = map(int, raw_input().split())
for i in xrange(N-1):
    new_t, new_a = map(int, raw_input().split())
    d = max((t-1)/new_t+1, (a-1)/new_a+1, 1)
    t, a = new_t*d, new_a*d
print t+a
