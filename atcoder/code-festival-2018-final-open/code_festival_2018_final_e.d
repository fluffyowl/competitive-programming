import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;

    auto st = new SegmentTree!(Tuple!(long, int), ((a, b) => min(a, b)), tuple(1L << 59, 1 << 29))(N+1);
    foreach (i; 0..N) st.update(i, tuple(A[i], i));

    long ans = 0;
    long amari = 0;

    for (int i = 0; i < N; ) {
        auto mn = st.query(i+1, min(N, i+K));
        if (st.query(i+1, min(N, i+K))[0] > A[i]) {
            auto t = st.query(i+1, min(N, i+K));
            long tameru = min(N - i, K);
            ans += max(0, (tameru - amari) * A[i]);
            amari = tameru - (t[1] - i);
            i = t[1];
        } else {
            int lo = i;
            int hi = min(N-1, i+K);
            while (hi - lo > 1) {
                int mid = (hi + lo) / 2;
                if (st.query(i+1, mid)[0] <= A[i]) {
                    hi = mid;
                } else {
                    lo = mid;
                }
            }
            ans += max(0, (hi - i - amari) * A[i]);
            amari = max(0, amari - (hi - i));
            i = hi;
        }
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
