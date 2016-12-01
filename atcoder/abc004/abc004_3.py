n = int(raw_input()) % 30
ans = [1,2,3,4,5,6]
for i in range(n):
    ans[i%5], ans[i%5+1] = ans[i%5+1], ans[i%5]
print ''.join(map(str, ans))
