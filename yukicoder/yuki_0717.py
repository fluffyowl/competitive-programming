N, M = map(int, raw_input().split())
A = raw_input()
B = raw_input()
print min(A.count('A'), B.count('A')) + min(A.count('B'), B.count('B'))
