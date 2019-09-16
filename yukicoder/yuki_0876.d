import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = readln.split.map!(to!long).array;

    auto B = iota(N-1).map!(i => A[i+1]-A[i]).array;
    auto st = new SegmentTree!(long, (a,b)=>a+b, 0)(N);
    foreach (i; 0..N-1) st.assign(i, B[i] != 0);

    while (Q--) {
        auto x = readln.split.map!(to!int);
        auto t = x[0];
        auto il = x[1] - 1;
        auto ir = x[2] - 1;
        if (t == 1) {
            auto v = x[3].to!long;
            if (il > 0) {
                B[il-1] += v;
                st.assign(il-1, B[il-1] != 0);
            }
            if (ir < N - 1) {
                B[ir] -= v;
                st.assign(ir, B[ir] != 0);
            }
        } else {
            if (il == ir) {
                writeln(1);
            } else {
                writeln(st.query(il, ir-1) + 1);
            }
        }
    }
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

    void add(int pos, T val) {
        pos += offset;
        table[pos] += val;
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

