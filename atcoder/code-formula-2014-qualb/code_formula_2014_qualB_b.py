s = raw_input()[::-1]
print sum(int(s[i]) for i in range(1, len(s), 2)), sum(int(s[i]) for i in range(0, len(s), 2))
