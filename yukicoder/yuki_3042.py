N = input()
D = {"iti": 1, "ni": 2, "san" : 3, "yon": 4}
A = [raw_input().split() for _ in xrange(N)]
A.sort(key=lambda x: (x[0], D[x[1]]))
for a in A:
    print a[0], a[1]
