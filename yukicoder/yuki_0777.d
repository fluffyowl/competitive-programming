import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    long[long] comp;
    auto B = A.map!(a => a[1]).array.sort().uniq().array;
    auto M = B.length.to!int;
    foreach (i; 0..M) comp[B[i]] = i;

    foreach (i; 0..N) A[i][1] = comp[A[i][1]];
    A.sort!"a[0] == b[0] ? a[1] < b[1] : a[0] > b[0]"();

    auto st = new SegmentTree!(long, max, 0L)(M);


    foreach (i; 0..N) {
        auto b = A[i][1].to!int;
        auto v = st.query(b+1, M-1);
        auto x = st.query(b, b);
        st.assign(b, max(v + A[i][2], x));
    }

    st.query(0, M-1).writeln;
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

