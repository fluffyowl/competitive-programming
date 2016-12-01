import datetime
a = map(int, raw_input().split())
b = map(int, raw_input().split())
print (datetime.datetime(2012, b[0], b[1]) - datetime.datetime(2012, a[0], a[1])).days
