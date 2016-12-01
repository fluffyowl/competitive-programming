a = int(raw_input())
b = int(raw_input())
a, b = min(a, b), max(a, b)
print min(10+a-b, b-a)
