K, N, F = map(int, raw_input().split())
A = map(int, raw_input().split())
print max(K*N-sum(A), -1)

