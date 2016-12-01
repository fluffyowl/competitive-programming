n = input()
p = []
for i in range(n):
    p.append(map(int, raw_input().split()))

ans = 0
for i in range(n-2):
    for j in range(i+1, n-1):
        for k in range(j+1, n):
            a = p[j][0] - p[i][0]
            b = p[j][1] - p[i][1]
            c = p[k][0] - p[i][0]
            d = p[k][1] - p[i][1]
            if (a*d-b*c)%2 == 0 and (a*d-b*c)!=0:
                ans += 1
print ans
