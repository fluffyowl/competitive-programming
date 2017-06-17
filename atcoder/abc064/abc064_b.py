n = input()
A = map(int, raw_input().split())
A.sort()
print A[-1] - A[0]
