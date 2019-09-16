a, b, c, d, e, f, g = map(int, input().split())

g -= 500 * min(g // 500, a)
g -= 100 * min(g // 100, b)
g -= 50 * min(g // 50, c)
g -= 10 * min(g // 10, d)
g -= 5 * min(g // 5, e)
g -= 1 * min(g // 1, f)

print ("YES" if g == 0 else "NO")
