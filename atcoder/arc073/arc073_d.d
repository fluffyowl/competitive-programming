import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 58;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = s[2];
    auto B = s[3];
    auto X = B ~ readln.split.map!(to!int).array;

    auto st1 = new LazySegmentTree!(long)(N+1);
    auto st2 = new LazySegmentTree!(long)(N+1);

    //AM.add(B, B, -INF-B);
    //AP.add(B, B, -INF+B);
    foreach (i; 0..N+1) {
        if (i == A) {
            st1.add(A, A, -A);
            st2.add(A, A, A);
        } else {
            st1.add(i, i, INF - i);
            st2.add(i, i, INF + i);
        }
    }

    foreach (i; 1..Q+1) {
        long m = min(st1.getVal(0, X[i]) + X[i], st2.getVal(X[i], N) - X[i]);
        st1.add(0, N, abs(X[i] - X[i-1]));
        st2.add(0, N, abs(X[i] - X[i-1]));
        long v1 = st1.getVal(X[i-1], X[i-1]);
        long v2 = st2.getVal(X[i-1], X[i-1]);
        long mv = min(m, v1 + X[i-1], v2 - X[i-1]);
        st1.add(X[i-1], X[i-1], -v1 + mv - X[i-1]);
        st2.add(X[i-1], X[i-1], -v2 + mv + X[i-1]);
    }

    long ans = INF;
    foreach (i; 0..N+1) ans = min(ans, st1.getVal(i, i) + i);
    foreach (i; 0..N+1) ans = min(ans, st2.getVal(i, i) - i);
    ans.writeln;
}



class LazySegmentTree(T) {
    T[] add_table;
    T[] min_table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        add_table = new T[](size);
        min_table = new T[](size);
    }

    void add(int a, int b, T num) {
        add(a, b, num, 0, 0, size/2-1);
    }

    void add(int a, int b, T num, int i, int l, int r) {
        if (a > r || b < l) {
            return;
        } if (a <= l && r <= b) {
            add_table[i] += num;
            min_table[i] += num;
        } else {
            add(a, b, num, i*2+1, l, (l+r)/2);
            add(a, b, num, i*2+2, (l+r)/2+1, r);
            min_table[i] = add_table[i] + min(min_table[i*2+1], min_table[i*2+2]);
        }
    }

    T getVal(int a, int b) {
        return getVal(a, b, 0, 0, size/2-1);
    }

    T getVal(int a, int b, int i, int l, int r) {
        if (a > r || b < l) {
            return INF * 5;
        } else if (a <= l && r <= b) {
            return min_table[i];
        }
        return
            add_table[i] + min(getVal(a, b, i*2+1, l, (l+r)/2),
                               getVal(a, b, i*2+2, (l+r)/2+1, r));
    }
}
