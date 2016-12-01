A, B, C, K = map(int, raw_input().split())
S, T = map(int, raw_input().split())
s = A*S+B*T
print s if S+T<K else s-(S+T)*C
