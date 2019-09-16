import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto P = readln.split.map!(to!int).array;
    auto G = new int[][](N);
    foreach (i; 1..N) {
        G[P[i-1]] ~= i;
    }

    auto st = new SegmentTree!(long, (a,b)=>a+b, 0L)(N);
    long ans = 0;

    void dfs(int n) {
        ans += st.query(0, n);
        st.add(n, 1);
        foreach (m; G[n]) {
            dfs(m);
        }
        st.add(n, -1);
    }

    dfs(0);
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

