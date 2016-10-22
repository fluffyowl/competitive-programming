N = input()
M = sorted(map(int, raw_input().split()))
print M[N/2] if N%2 else (M[N/2-1]+M[N/2])/2.0
