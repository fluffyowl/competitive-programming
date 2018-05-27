import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!long).array;
    auto B = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto C = new long[](N);
    foreach (i; 0..N-1) C[i+1] = C[i] + A[i];
    
    auto table = new long[][](N+1, N+1);
    auto st = new SegmentTree!(Tuple!(long, int), (a, b) => max(a, b), tuple(-(1L<<59), -1))(N);
    auto stack = new Tuple!(int, int)[](N+10);

    foreach (m; 0..M) {
        foreach (i; 0..N) st.assign(i, tuple(B[i][m], i));
        stack[0] = tuple(0, N-1);
        int sp = 0;
        while (sp >= 0) {
            auto l = stack[sp][0];
            auto r = stack[sp][1];
            sp -= 1;
            auto t = st.query(l, r);
            auto v = t[0];
            auto p = t[1];
            table[l][p] += v;
            table[l][r+1] -= v;
            table[p+1][p] -= v;
            table[p+1][r+1] += v;
            if (l <= p-1) stack[++sp] = tuple(l, p-1);
            if (r >= p+1) stack[++sp] = tuple(p+1, r);
        }
    }

    long ans = 0;
    foreach (i; 0..N) foreach (j; 0..N) table[i][j+1] += table[i][j];
    foreach (j; 0..N) foreach (i; 0..N) table[i+1][j] += table[i][j];
    foreach (i; 0..N) foreach (j; i..N) ans = max(ans, table[i][j] - C[j] + C[i]);
    ans.writeln;
}


class SegmentTree(T, alias op, T e) {
    T[] table;
    int size;
    int offset;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
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
