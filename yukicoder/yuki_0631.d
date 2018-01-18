import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto st = new LazySegmentTree!long(N);
    foreach (i; 0..N) st.add(i, i, -3*i);
    foreach (i; 0..N-1) st.add(i, i, A[i]);

    auto Q = readln.chomp.to!int;
    while(Q--) {
        auto s = readln.split.map!(to!int);
        st.add(s[0]-1, s[1]-1, s[2].to!long);
        writeln(st.getVal(0, N-1) + 3 * (N - 1));
    }
}


class LazySegmentTree(T) {
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
            table[i] = max(table[i*2+1], table[i*2+2]);
        }
    }

    T getVal(int a, int b) {
        return getVal(a, b, 0, 0, size/2-1);
    }

    T getVal(int a, int b, int i, int l, int r) {
        eval(i, l, r);

        if (a > r || b < l) return 0;
        if (a <= l && r <= b) return table[i];
        return
            max(getVal(a, b, i*2+1, l, (l+r)/2),
                getVal(a, b, i*2+2, (l+r)/2+1, r));
    }
}

