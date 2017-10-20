A, N = map(int, raw_input().split())
H = [int(raw_input()) for _ in xrange(N-1)]
H.append(A)
H.sort()
H = H[::-1]

for i in xrange(N):
    if H[i] == A:
        a = i + 1
        ans = str(a)
        if a % 10 == 1:
            ans += 'st'
        elif a % 10 == 2:
            ans += 'nd'
        elif a % 10 == 3:
            ans += 'rd'
        else:
            ans += 'th'
        print ans
        exit()

