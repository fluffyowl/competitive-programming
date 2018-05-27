N = input() - 1
X = input()
A = input()
B = input()

ans1 = (X - 1) / A + 1
ans2 = (2**N - X - 1) / B + 1

print min(ans1, ans2)

