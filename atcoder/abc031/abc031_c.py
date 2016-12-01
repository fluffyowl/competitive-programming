N = int(raw_input())
nums = map(int, raw_input().split())
t_max = float('-inf')
for i in range(N):
    a_max = float('-inf')
    ttt = float('-inf')
    for j in range(N):
        if i == j:
            continue
        a = sum(nums[min(i, j)+1:max(i, j)+1:2])
        t = sum(nums[min(i, j):max(i, j)+1:2])
        if a > a_max:
            a_max = a
            ttt = t
    if ttt > t_max:
        t_max = ttt

print t_max
