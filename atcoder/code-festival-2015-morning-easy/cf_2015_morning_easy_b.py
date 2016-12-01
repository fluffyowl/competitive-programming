n = input()
s = list(raw_input())
print -1 if n%2 else len(filter(lambda x:x[0]!=x[1], zip(s[:n/2], s[n/2:])))
