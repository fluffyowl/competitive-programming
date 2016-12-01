def input_to_int():
    return map(int, raw_input().split())

N, K = input_to_int()
a = list(input_to_int())
s = 0
if K > N/2 + N%2:
    K = N-K+1
for i in range(N/2):
    s += a[i] * min((i+1), K)
    s += a[N-1-i] * min((i+1), K)
if N%2 == 1:
    s += a[N/2] * min((N/2+1), K)
print s
