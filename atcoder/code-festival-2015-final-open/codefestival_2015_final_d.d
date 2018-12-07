import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int MAX = 10^^5+10;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto B = new int[](MAX);
    foreach (a; A) B[a[0]] += 1, B[a[1]] -= 1;
    foreach (i; 0..MAX-1) B[i+1] += B[i];

    auto st = new SegmentTree!(int, (a, b) => max(a, b), 0)(MAX);
    foreach (i; 0..MAX) st.update(i, B[i]);

    long ans = 1L << 59;

    foreach (a; A) {
        long tmp1 = st.query(0, a[0]-1);
        long tmp2 = st.query(a[0], a[1]-1) - 1;
        long tmp3 = st.query(a[1], MAX-1);
        ans = min(ans, max(tmp1, tmp2, tmp3));
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
