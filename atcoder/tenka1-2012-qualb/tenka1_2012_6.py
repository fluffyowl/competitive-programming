import string

def is_camel(s):
    s = s.strip('_')
    s = s.rstrip('_')
    if len(s) == 0:
        return True
    if '_' in s:
        return False
    if s[0].isdigit():
        return False
    if s[0].isupper():
        return False
    return True

def is_snake(s):
    s = s.strip('_')
    s = s.rstrip('_')
    if len(s) == 0:
        return True
    if '__' in s:
        return False
    if any(c.isupper() for c in s):
        return False
    if any(c[0].isdigit() for c in s.split('_')):
        return False
    return True

def camel_to_snake(s):
    for c in string.ascii_uppercase:
        s = s.replace(c, '_'+c.lower())
    return s

def snake_to_camel(s):
    for a in string.ascii_lowercase:
        for b in string.ascii_lowercase:
            s = s.replace(a+'_'+b, a+b.upper())
            s = s.replace(a+'_'+b.upper(), a+b.upper())
            s = s.replace(a.upper()+'_'+b, a.upper()+b.upper())
            s = s.replace(a.upper()+'_'+b.upper(), a.upper()+b.upper())
    for a in xrange(10):
        for b in string.ascii_lowercase:
            a = str(a)
            s = s.replace(a+'_'+b, a+b.upper())
            s = s.replace(a+'_'+b.upper(), a+b.upper())
    return s

S = raw_input()
if is_camel(S):
    print camel_to_snake(S)
elif is_snake(S):
    print snake_to_camel(S)
else:
    print S
