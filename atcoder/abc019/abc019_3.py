N = int(raw_input())
a = map(int, raw_input().split())
ans = set()
for m in a:
    while m % 2 == 0:
        m /= 2
    ans.add(m)
print len(ans)
