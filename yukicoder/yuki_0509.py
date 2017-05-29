N = raw_input()
ans1 = len(N) * 2
hoge = [1, 0, 0, 0, 1, 0, 1, 0, 2, 1]
for i in N:
    ans1 += hoge[int(i)]
ans1 += 1

ans2 = len(N)
for i in N:
    ans2 += hoge[int(i)] * 2
ans2 += 2

print min(ans1, ans2)

