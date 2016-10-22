H, W, N, K = map(int, raw_input().split())
a = H*W%N if H*W%N > 0 else N
print 'YES' if K == a else 'NO'

