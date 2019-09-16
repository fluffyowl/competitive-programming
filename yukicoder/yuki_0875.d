import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = readln.split.map!(to!int).array;

    auto st = new SegmentTree!(Tuple!(int, int), min, tuple(1<<29, 1<<29))(N);
    foreach (i, a; A) st.assign(i.to!int, tuple(a, i.to!int));

    while (Q--) {
        auto x = readln.split.map!(to!int);
        auto t = x[0];
        auto il = x[1] - 1;
        auto ir = x[2] - 1;
        if (t == 1) {
            auto al = st.query(il, il)[0];
            auto ar = st.query(ir, ir)[0];
            st.assign(il, tuple(ar, il));
            st.assign(ir, tuple(al, ir));
        } else {
            writeln(st.query(il, ir)[1] + 1);
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

