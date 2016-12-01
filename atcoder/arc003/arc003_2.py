s = []
for i in range(input()):
    s.append(raw_input())
for i in sorted(s, key=lambda x:x[::-1]):
    print i
