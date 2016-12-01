n = input()
s = [raw_input() for i in range(n)]
print sorted([s[i]+s[j] for i in range(n) for j in range(n) if i != j])[0]
