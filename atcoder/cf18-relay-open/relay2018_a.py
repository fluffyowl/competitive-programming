A = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
B = {}
for i in xrange(7):
    B[A[i]] = i

N = input()
for i in xrange(N):
    print A[(B[raw_input()] + 1) % 7]
