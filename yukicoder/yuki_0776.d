import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

alias Node = Tuple!(long, "sum", long, "lmax", long, "rmax", long, "allmax");

Node merge(Node l, Node r) {
    long lmax = max(l.lmax, l.sum + r.lmax);
    long rmax = max(r.rmax, r.sum + l.rmax);
    long allmax = max(l.allmax, r.allmax, l.rmax + r.lmax);
    return Node(l.sum + r.sum, lmax, rmax, allmax);
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

    void assign(int pos, T val) {
        pos += offset;
        table[pos] = val;
        while (pos > 1) {
            pos /= 2;
            table[pos] = op(table[pos*2], table[pos*2+1]);
        }
    }

    T query(int l, int r) {
        if (r < l) return e;
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


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = readln.split.map!(to!long).array;

    auto st = new SegmentTree!(Node, merge, Node(0L, -INF, -INF, -INF))(N);
    foreach (i; 0..N) st.assign(i, Node(A[i], A[i], A[i], A[i]));

    while (Q--) {
        auto q = readln.split;
        if (q[0] == "set") {
            auto i = q[1].to!int - 1;
            auto x = q[2].to!long;
            st.assign(i, Node(x, x, x, x));
        } else {
            auto l1 = q[1].to!int - 1;
            auto l2 = q[2].to!int - 1;
            auto r1 = q[3].to!int - 1;
            auto r2 = q[4].to!int - 1;
            l2 = min(l2, r2);
            r1 = max(l1, r1);
            long ans = -INF;
            if (l2 < r1) {
                auto v1 = st.query(l1, l2).rmax;
                auto v2 = st.query(l2+1, r1-1).sum;
                auto v3 = st.query(r1, r2).lmax;
                ans = v1 + v2 + v3;
            } else {
                if (l1 < r1) {
                    auto v1 = st.query(l1, r1-1).rmax;
                    auto v2 = st.query(r1, r2).lmax;
                    ans = max(ans, v1 + v2);
                }
                if (l2 < r2) {
                    auto v1 = st.query(l1, l2).rmax;
                    auto v2 = st.query(l2+1, r2).lmax;
                    ans = max(ans, v1 + v2);
                }
                auto hoge = st.query(r1, l2);
                ans = max(ans, st.query(r1, l2).allmax);
            }
            ans.writeln;
        }
    }
}
