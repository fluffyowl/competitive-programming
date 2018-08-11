import datetime

dt = datetime.datetime.strptime(raw_input(), '%Y/%m/%d')
dt += datetime.timedelta(days=2)
print dt.strftime('%Y/%m/%d')

