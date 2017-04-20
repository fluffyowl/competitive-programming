import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto Q = readln.chomp.to!int;

    auto st = new LazySegmentTree!(int)(N);
    auto st2 = new LazySegmentTree!(int)(N);
    long score1 = 0;
    long score2 = 0;
    
    foreach (q; 0..Q) {
        auto s = readln.split.map!(to!int);
        auto x = s[0];
        auto l = s[1];
        auto r = s[2];
        
        if (x == 0) {
            auto used = st2.getVal(l, r);
            auto m = st.getVal(l, r);
            auto a = (used + m) / 2;
            auto b =  used - a;
            if (m > 0) score1 += a;
            if (m < 0) score2 += b;
        }
        else if (x == 1) {
            st.assign(l, r, 1);
            st2.assign(l, r, 1);
        }
        else if (x == 2) {
            st.assign(l, r, -1);
            st2.assign(l, r, 1);
        }

    }

    auto used = st2.getVal(0, N-1);
    auto m = st.getVal(0, N-1);
    auto a = (used + m) / 2;
    auto b =  used - a;
    score1 += a;
    score2 += b;
    
    writeln(score1, " ", score2);
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

        table[i] = lazy_[i] * (r - l + 1);
        if (l != r) {
            lazy_[i*2+1] = lazy_[i];
            lazy_[i*2+2] = lazy_[i];
        }

        lazy_[i] = 0;
        
        return;
    }

    void assign(int a, int b, T num) {
        return assign(a, b, num, 0, 0, size/2-1);
    }
 
    void assign(int a, int b, T num, int i, int l, int r) {
        eval(i, l, r);
        
        if (a > r || b < l) return;
        if (lazy_[i] == num) return;
        if (a <= l && r <= b) {
            lazy_[i] = num;
            eval(i, l, r);
            return;
        }
        else {
            assign(a, b, num, i*2+1, l, (l+r)/2);
            assign(a, b, num, i*2+2, (l+r)/2+1, r);
            table[i] = table[i*2+1] + table[i*2+2];
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
            getVal(a, b, i*2+1, l, (l+r)/2) +
            getVal(a, b, i*2+2, (l+r)/2+1, r);
    }
}

