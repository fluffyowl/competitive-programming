# -*- coding: utf-8 -*-
import re
print max(map(len, re.findall(u'…*', raw_input().decode("utf-8"))))
