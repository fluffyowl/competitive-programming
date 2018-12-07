import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto K = s[1].to!long;
    auto A = readln.split.map!(to!long).array;

    auto B = N.iota.map!(i => tuple(A[i], i)).array;

    auto st = new SegmentTree!(Tuple!(long, int), (a, b) => min(a, b), tuple(1L<<59, 0))(N);
    foreach (i; 0..N) st.update(i, B[i]);

    long[long] D;
    long X = 0;

    void dfs(int l, int r, long level) {
        auto t = st.query(l, r);
        D[r-l+1] += t[0] - level;
        X += 2 * (t[0] - level);
        if (t[1] > l) dfs(l, t[1]-1, t[0]);
        if (t[1] < r) dfs(t[1]+1, r, t[0]);
    }

    dfs(0, N-1, 0);
    long ans = N + (A.sum - K) * 2 + X;

    auto keys = D.keys.array;
    keys.sort();

    foreach (key; keys) {
        auto n = min(D[key], K / key);
        ans -= 2 * n;
        if (n < D[key]) break;
        K -= n * key;
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
