n = input()
A = map(int, raw_input().split())
a = sum(map(lambda x: x % 2, A))
print "YES" if a % 2 == 0 else "NO"
