N = int(raw_input())
A = map(int, raw_input().split())
s = set()
right = 0
left = 0
ans = 1
s.add(A[0])

while right < N-1:
    right += 1
    if A[right] in s:
        while A[left] != A[right]:
            s.remove(A[left])
            left += 1
        left += 1
    s.add(A[right])
    ans = max(ans, right - left + 1)
print ans
