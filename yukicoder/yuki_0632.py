def ok(x):
    if x[0] < x[1] and x[1] > x[2] and x[0] != x[2]:
        return True
    if x[0] > x[1] and x[1] < x[2] and x[0] != x[2]:
        return True
    return False

S = raw_input()
A = map(int, S.replace('?', '1').split())
B = map(int, S.replace('?', '4').split())

ans = ''
if ok(A):
    ans += '1'
if ok(B):
    ans += '4'
print ans

