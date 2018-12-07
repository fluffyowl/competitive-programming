import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto TA = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    auto st_max = new LazySegmentTree!(int, max, -(1<<29))(N);
    auto st_min = new LazySegmentTree!(int, min, (1<<29))(N);
    auto st_plus = new SegmentTree!(Tuple!(long, int), min, tuple(1L<<59, 1<<29))(N);
    auto st_minus = new SegmentTree!(Tuple!(long, int), min, tuple(1L<<59, 1<<29))(N);

    long ans = TA.map!(ta => ta[1]).sum;
    int pos = 0;

    foreach (i; 0..N) {
        if (TA[i][0] == 0) {
            pos -= 1;
            st_max.add(i, i, pos);
            st_min.add(i, i, pos);
            st_minus.update(i, tuple(TA[i][1], i));
        } else {
            pos += 1;
            st_max.add(i, i, pos);
            st_min.add(i, i, pos);
            st_plus.update(i, tuple(TA[i][1], i));
        }

        if (pos < 0) {
            int lo = -1;
            int hi = i;
            while (hi - lo > 1) {
                int mid = (hi + lo) / 2;
                if (st_max.query(mid, i) < K)
                    hi = mid;
                else
                    lo = mid;
            }
            auto t = st_minus.query(hi, i);
            ans -= t[0];
            st_minus.update(t[1], tuple(1L<<59, 1<<29));
            st_max.add(t[1], i, 1);
            st_min.add(t[1], i, 1);
            pos = 0;
        } else if (pos > K) {
            int lo = -1;
            int hi = i;
            while (hi - lo > 1) {
                int mid = (hi + lo) / 2;
                if (st_min.query(mid, i) > 0)
                    hi = mid;
                else
                    lo = mid;
            }
            auto t = st_plus.query(hi, i);
            ans -= t[0];
            st_plus.update(t[1], tuple(1L<<59, 1<<29));
            st_max.add(t[1], i, -1);
            st_min.add(t[1], i, -1);
            pos = K;
        }
    }

    ans.writeln;
}


class SegmentTree(T, alias op, T e) {
    T[] table;
    int size;
    int offset;

    this(int n) {
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 1;
        table = new T[](size);
        fill(table, e);
        offset = size / 2;
    }

    void update(int pos, T val) {
        pos += offset;
        table[pos] = val;
        while (pos > 1) {
            pos /= 2;
            table[pos] = op(table[pos*2], table[pos*2+1]);
        }
    }

    T query(int l, int r) {
        return query(l, r, 1, 0, offset-1);
    }

    T query(int l, int r, int i, int a, int b) {
        if (b < l || r < a) {
            return e;
        } else if (l <= a && b <= r) {
            return table[i];
        } else {
            return op(query(l, r, i*2, a, (a+b)/2), query(l, r, i*2+1, (a+b)/2+1, b));
        }
    }
}


class LazySegmentTree(T, alias op, T e) {
    T[] table;
    T[] lazy_;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new T[](size);
        lazy_ = new T[](size);
        fill(table, 0);
        fill(lazy_, 0);
    }

    void eval(int i, int l, int r) {
        if (lazy_[i] == 0) return;

        table[i] += lazy_[i];
        if (l != r) {
            lazy_[i*2+1] += lazy_[i];
            lazy_[i*2+2] += lazy_[i];
        }

        lazy_[i] = 0;
    }

    void add(int a, int b, T num) {
        add(a, b, num, 0, 0, size/2-1);
    }

    void add(int a, int b, T num, int i, int l, int r) {
        eval(i, l, r);

        if (a > r || b < l) return;
        if (a <= l && r <= b) {
            lazy_[i] += num;
            eval(i, l, r);
        } else {
            add(a, b, num, i*2+1, l, (l+r)/2);
            add(a, b, num, i*2+2, (l+r)/2+1, r);
            table[i] = op(table[i*2+1], table[i*2+2]);
        }
    }

    T query(int a, int b) {
        return query(a, b, 0, 0, size/2-1);
    }

    T query(int a, int b, int i, int l, int r) {
        eval(i, l, r);

        if (a > r || b < l) return e;
        if (a <= l && r <= b) return table[i];
        return
            op(query(a, b, i*2+1, l, (l+r)/2),
                query(a, b, i*2+2, (l+r)/2+1, r));
    }
}
