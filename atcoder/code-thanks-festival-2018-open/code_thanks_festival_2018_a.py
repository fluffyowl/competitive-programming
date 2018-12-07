T, A, B, C, D = map(int, raw_input().split())

if A + C <= T:
    print B + D
elif C <= T:
    print D
elif A <= T:
    print B
else:
    print 0
