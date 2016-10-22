a = raw_input()
N = input()
b = raw_input()

o1, o2 = a.count('o'), b.count('o')
if N == 0:
    ans = 'SUCCESS' if a != b else 'FAILURE'
elif N == 1:
    if a[0]+a[2]+a[1] == b or a[1]+a[0]+a[2] == b:
        ans = 'FAILURE'
    else:
        ans = 'SUCCESS'
elif o1 == o2 == 1 or o1 == o2 == 2:
    ox = 'o' if o1 == 1 else 'x'
    diff = abs(a.index(ox)-b.index(ox))
    if diff <= N:
        ans = 'FAILURE'
    else:
        ans = 'SUCCESS'
elif o1 == o2 == 3:
    ans = 'FAILURE'
else:
    ans = 'SUCCESS'
print ans

