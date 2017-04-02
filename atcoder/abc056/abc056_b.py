w, a, b =map(int, raw_input().split())
if a > b:
    a, b = b, a

print max(0, b-a-w)
