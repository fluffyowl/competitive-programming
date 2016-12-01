N, A, B=map(int, raw_input().split())
print sum(not(A<=int(raw_input())<B) for _ in range(N))
