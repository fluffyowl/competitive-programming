import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 10^^9 + 100;

int[] solve(Tuple!(int, int)[] A) {
    int N = A.length.to!int;

    int[int] comp;
    auto B = A.map!(a => a[1]).array;
    B = 0 ~ B.sort().uniq().array;
    foreach (i; 0..B.length.to!int) comp[B[i]] = i;
    foreach (i; 0..N) A[i][1] = comp[A[i][1]];
    auto K = B.length.to!int;

    auto next = new int[](N);
    auto st = new SegmentTree!(int, min, INF)(K);

    foreach_reverse (i; 0..N) {
        next[i] = st.query(0, A[i][1]-1);
        st.update(A[i][1], i);
    }

    auto next2 = new int[](N);
    auto st2 = new SegmentTree!(int, min, INF)(K+1);

    foreach_reverse (i; 0..N) {
        next2[i] = st2.query(0, A[i][1]-1);
        st2.update(A[i][1], next[i]);
    }

    return next2;
}

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto K = A.map!(a => a[1]).reduce!max;
    auto B = new Tuple!(int, int)[][](K);
    auto next = new int[](N);
    auto dp = new int[](N+1);

    foreach (i; 0..N) {
        A[i][1] -= 1;
        B[A[i][1]] ~= tuple(i, A[i][0]);
    }

    foreach (i; 0..K) {
        auto tmp = solve(B[i]);
        foreach (j; 0..B[i].length.to!int) {
            next[B[i][j][0]] = tmp[j] == INF ? INF : B[i][tmp[j]][0];
        }
    }

    foreach (i; 0..N) {
        dp[i+1] = max(dp[i+1], dp[i]);
        if (next[i] == INF) continue;
        dp[next[i]+1] = max(dp[next[i]+1], dp[i]+1);
    }

    dp.reduce!max.writeln;
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
