import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    int n;
    long k;
    scanf("%d %lld", &n, &k);

    auto st = new SegmentTree(n+1);
    foreach (i; 0..n) st.add(i, 1);
    auto ans = new int[](n);
    long p = n / k;
    long q = n % k;
    
    for (int i = n-1; i >= 0; i--) {
        if (q == 0 && p > 0) p -= 1, q = k;
        int hi = n-1;
        int lo = -1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (st.sum(0, mid) >= p+1) hi = mid;
            else lo = mid;
        }
        ans[n-i-1] = hi + 1;
        st.add(hi, -1);

        long r = q * i;
        p = r / k;
        q = r % k;
    }

    ans.each!(writeln);
}


class SegmentTree {
    int[] table;
    int size;

    this(int n) {
        size = 1;
        while (size < n) size *= 2;
        size *= 2;
        table = new int[](size);
    }

    void add(int pos, int num) {
        return add(pos, num, 0, 0, size/2-1);
    }
    
    void add(int pos, int num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    int sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    int sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                sum(pl, pr, i*2+1, left, (left+right)/2) +
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
    }

    int lower_bound(int n) {
        return lower_bound(n, 0, 0, size/2-1);
    }
    
    int lower_bound(int n, int i, int left, int right) {
        if (left == right)
            return (table[i] >= n) ? left : -1;
        auto mid = (left + right) / 2;
        if (table[i*2+1] >= n)
            return lower_bound(n, i*2+1, left, mid);
        else
            return lower_bound(n-table[i*2+1], i*2+2, mid+1, right);
    }

    
    unittest {
        auto st = new SegmentTree(100);
        st.add(5, 1);
        st.add(40, 1);
        assert(st.sum(0, 50) == 2);
        assert(st.lower_bound(1) == 5);
        assert(st.lower_bound(2) == 40);
        assert(st.lower_bound(3) == -1);
    }

}
