D = map(int, raw_input().split())
J = map(int, raw_input().split())
print sum(map(max, zip(D, J)))
