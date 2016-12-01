input()
print sum(2**i*n for i,n in enumerate(map(int, raw_input().split())[::-1]))
