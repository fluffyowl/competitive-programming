N = int(raw_input())
a = map(int, raw_input().split())
a.append(float('-inf'))
left = 0
right = 0
s = 0
while left < N:
    while a[right] < a[right+1]:
        right += 1
    s += sum(range(1, right-left+2))
    left, right = right+1, right+1
print s
