class SegmentTree:
    class Node:
        def __init__(self, l, r, n):
            self.l = l
            self.r = r
            self.n = n
            self.left_child = None
            self.right_child = None

        def update(self, i, n):
            if self.l <= i < self.r:
                self.n += n
                if self.right_child is None:
                    return
                if i < self.l+(self.r-self.l)/2:
                    self.left_child.update(i, n)
                else:
                    self.right_child.update(i, n)

        def get_sum(self, l, r):
            ret = 0
            if r <= self.l or self.r <= l:
                return 0
            elif l <= self.l and self.r <= r:
                return self.n
            else:
                return self.left_child.get_sum(l, r) + self.right_child.get_sum(l, r)
            
    def __init__(self, n):
        m = 1
        while m < n:
            m *= 2
        self.root = self._construct(0, m)

    def _construct(self, l, r):
        node = self.Node(l, r, 0)
        if r-l <= 1:
            return node
        mid = l+(r-l)/2
        node.left_child = self._construct(l, mid)
        node.right_child = self._construct(mid, r)
        return node

    def update(self, i, n):
        self.root.update(i, n)
    
    def get_sum(self, l, r):
        return self.root.get_sum(l, r)

W_MAX = 1000001
N, K = map(int, raw_input().split())
sg = SegmentTree(W_MAX)
ans = 0
d = {}
for _ in xrange(N):
    w = int(raw_input())
    #if w in d:
    #    d[w] += 1
    #else:
    #    d[w] = 1
    if w >= 0 and sg.get_sum(w, W_MAX) < K:
        ans += 1
        sg.update(w, 1)
        #print d
        #print w, sg.get_sum(w, W_MAX)
    elif w < 0 and sg.get_sum(-w, -w+1) > 0:
        ans -= 1
        sg.update(-w, -1)

print ans

