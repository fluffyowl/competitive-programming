N, K = map(int, raw_input().split())
seq = [0 for i in range(N)]
for i in range(N):
    seq[i] = int(raw_input())

left, right = 0, 0
product = seq[0]
max_len = 0

while True:
    if left == N-1:
        break
    if product == 0:
        max_len = N
        break
    if right == N-1:
        if product > K:
            left += 1
            product /= seq[left]
        else:
            max_len = max(right-left+1, max_len)
            break
    elif left == right:
        if product > K:
            left += 1
            right += 1
            product = seq[left]
        else:
            max_len = max(right-left+1, max_len)
            right += 1
            product *= seq[right]
    else:
        if product > K:
            left += 1
            product /= seq[left-1]
        else:
            max_len = max(right-left+1, max_len)
            right += 1
            product *= seq[right]

print max_len
