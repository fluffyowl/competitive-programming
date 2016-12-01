x, y = map(int, raw_input().split())
k = input()
print x+k if y>=k else x+y-(k-y)
