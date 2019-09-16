A, B = map(int, raw_input().split())
A += 1

print "YES" if A <= B else "NO"
print max(A, B) - min(A, B)

