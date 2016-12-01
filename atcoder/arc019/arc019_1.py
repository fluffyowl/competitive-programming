s = raw_input()
for a, b in [('O', '0'), ('D', '0'), ('I', '1'), ('Z', '2'), ('S', '5'), ('B', '8')]:
    s = s.replace(a, b)
print s
