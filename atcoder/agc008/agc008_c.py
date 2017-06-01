a, b, c, d, e, f, g = map(int, raw_input().split())
if a > 0 and d > 0 and e > 0:
    ans1 = b + a / 2 * 2 + d / 2 * 2 + e / 2 * 2
    ans2 = b + 3 + (a-1) / 2 * 2 + (d-1) / 2 * 2 + (e-1) / 2 * 2
    print max(ans1, ans2)
else:
    print b + a / 2 * 2 + d / 2 * 2 + e / 2 * 2
