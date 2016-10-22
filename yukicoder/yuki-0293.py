A, B = ['%011d'%s for s in map(int, raw_input().split())]
def ans(n):
    print int(n)
    exit()
for a, b in zip(A, B):
    if a == '4' and b == '7':
        ans(A)
    elif a == '7' and b == '4':
        ans(B)
    elif a > b:
        ans(A)
    elif a < b:
        ans(B)
