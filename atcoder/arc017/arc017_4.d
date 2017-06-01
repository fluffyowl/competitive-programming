import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;



void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    auto diff = new SegmentTree!long(N-1);
    foreach (i; 0..N-1) diff.assign(i, abs(A[i+1] - A[i]));
    auto st = new LazySegmentTree!long(N);
    foreach (i; 0..N) st.add(i, i, A[i]);
    
    auto M = readln.chomp.to!int;
    while (M--) {
        auto s = readln.split.map!(to!int);
        auto t = s[0];
        auto l = s[1] - 1;
        auto r = s[2] - 1;

        if (t == 0) {
            if (l == r)
                writeln(st.getVal(l, l));
            else 
                writeln(gcd(st.getVal(l, l), diff.get_gcd(l, r-1)));
        }
        else {
            st.add(l, r, t);
            if (l > 0)
                diff.assign(l-1, abs(st.getVal(l, l) - st.getVal(l-1, l-1)));
            if (l < N - 1)
                diff.assign(l, abs(st.getVal(l, l) - st.getVal(l+1, l+1)));
            if (l == r)
                continue;
            if (r > 0)
                diff.assign(r-1, abs(st.getVal(r, r) - st.getVal(r-1, r-1)));
            if (r < N - 1)
                diff.assign(r, abs(st.getVal(r, r) - st.getVal(r+1, r+1)));
        }
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
        if (lazy_[i] == 0)
            return;

        table[i] += lazy_[i];
        if (l != r) {
            lazy_[i*2+1] += lazy_[i] / 2;
            lazy_[i*2+2] += lazy_[i] / 2;
        }
        lazy_[i] = 0;
    }

    void add(int a, int b, T num) {
        return add(a, b, num, 0, 0, size/2-1);
    }
 
    void add(int a, int b, T num, int i, int l, int r) {
        eval(i, l, r);
        
        if (a > r || b < l)
            return;
        else if (a <= l && r <= b) {
            lazy_[i] += (r - l + 1) * num;
            eval(i, l, r);
            return;
        }
        else {
            add(a, b, num, i*2+1, l, (l+r)/2);
            add(a, b, num, i*2+2, (l+r)/2+1, r);
            table[i] = table[i*2+1] + table[i*2+2];
        }
    }
 
    T getVal(int a, int b) {
        return getVal(a, b, 0, 0, size/2-1);
    }
 
    T getVal(int a, int b, int i, int l, int r) {
        eval(i, l, r);
        
        if (a > r || b < l)
            return 0;
        else if (a <= l && r <= b)
            return table[i];
        else
            return
                getVal(a, b, i*2+1, l, (l+r)/2) +
                getVal(a, b, i*2+2, (l+r)/2+1, r);
    }
}


class SegmentTree(T) {
    T[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new T[](size);
        fill(table, 0);
    }

    void assign(int pos, T num) {
        assign(pos, num, 0, 0, size/2-1);
    }

    void assign(int pos, T num, int i, int left, int right) {
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = gcd(table[i*2+1], table[i*2+2]);
    }

    T get_gcd(int pl, int pr) {
        return get_gcd(pl, pr, 0, 0, size/2-1);
    }

    T get_gcd(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                gcd(get_gcd(pl, pr, i*2+1, left, (left+right)/2),
                    get_gcd(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}


unittest {
    auto st2 = new SegmentTree!long(100);
    st2.assign(5, 5);
    st2.assign(6, 25);
    st2.assign(7, 100);
    st2.assign(8, 97);
    assert(st2.get_gcd(5, 7) == 5);
    assert(st2.get_gcd(6, 7) == 25);
    assert(st2.get_gcd(5, 8) == 1);
}
