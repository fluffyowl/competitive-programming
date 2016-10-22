def is_kadomatsu(a, b, c):
    if a == b or b == c or c == a:
        return False
    if b < a and b < c:
        return True
    if b > a and b > c:
        return True
    return False

a, b, c = map(int, raw_input().split())
print 'INF' if is_kadomatsu(a, b, c) else sum(is_kadomatsu(a%i, b%i, c%i) for i in xrange(1, max(a,b,c)+2))
        

