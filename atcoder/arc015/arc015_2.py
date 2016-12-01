N = int(raw_input())
ans = [0 for i in range(6)]
for i in range(N):
    MT, mt = map(float, raw_input().split())
    if MT >= 35:
        ans[0] += 1
    elif 30 <= MT < 35:
        ans[1] += 1
    elif 25 <= MT < 30:
        ans[2] += 1
    if mt >= 25:
        ans[3] += 1
    if mt < 0 and MT >= 0:
        ans[4] += 1
    if MT < 0:
        ans[5] += 1
print ' '.join(map(str, ans))
