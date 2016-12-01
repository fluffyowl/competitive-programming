s = raw_input()
K = int(raw_input())
st = set()
for i in range(len(s)-K+1):
    st.add(s[i:i+K])
print len(st)
