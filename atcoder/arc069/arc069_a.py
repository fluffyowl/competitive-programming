s, c = map(int, raw_input().split())

first = min(s, c/2)
ans = first
s -= first
c -= first*2

ans += c/4

print ans
