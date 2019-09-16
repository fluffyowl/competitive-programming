import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2].to!long;
    auto A = iota(M).map!(_ => readln.split.map!(to!int).array).array;
    A.sort!"a[0] < b[0]";

    auto st = new SegmentTree!(long, max, -(1L<<59))(N+1);
    st.assign(0, 0);

    int idx = 0;

    foreach (i; 0..N) {
        long tmp = max(st.query(i, i), st.query(0, i-1) - K);
        while (idx < M && A[idx][0] - 1 == i) {
            long v = st.query(A[idx][1], A[idx][1]);
            long cost = tmp + A[idx][2] - K;
            if (A[idx][1] == N) cost += K;
            st.assign(A[idx][1], max(v, cost));
            idx += 1;
        }
    }

    st.query(0, N).writeln;
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
