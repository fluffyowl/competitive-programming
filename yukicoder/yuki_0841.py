def ok(n):
    return n in ["Sat", "Sun"]

n, m = input().split()
if ok(n) and ok(m):
    print ("8/33")
elif ok(n):
    print ("8/32")
else:
    print("8/31")
