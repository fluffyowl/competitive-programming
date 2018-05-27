import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new Tuple!(int, long)[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    long mst_cost = 0;
    auto H = new Tuple!(int, long)[][](N);
    auto P = new Tuple!(int, long)[](N);
    auto D = new int[](N);
    auto used = new bool[](N);
    auto q = new BinaryHeap!(Array!(Tuple!(int, int, long)), "a[2] > b[2]")();
    q.insert(tuple(-1, 0, 0L));

    while (!q.empty) {
        auto t = q.front;
        auto from = t[0];
        auto cur = t[1];
        auto d = t[2];
        q.removeFront;
        if (used[cur]) continue;
        used[cur] = true;
        mst_cost += d;
        if (from != -1) {
            H[from] ~= tuple(cur, d);
            H[cur] ~= tuple(from, d);
        }
        foreach (m; G[cur]) {
            auto tar = m[0];
            auto nd = m[1];
            if (used[tar]) continue;
            q.insert(tuple(cur, tar, nd));
        }
    }

    void dfs(int n, int p, long c, int d) {
        P[n] = tuple(p, c);
        D[n] = d;
        foreach (to; H[n]) if (to[0] != p) dfs(to[0], n, to[1], d+1);
    }

    dfs(0, -1, 0, 0);


    auto Q = readln.chomp.to!int;
    while (Q--) {
        s = readln.split.map!(to!int);
        auto a = s[0]-1;
        auto b = s[1]-1;
        if (D[a] > D[b]) swap(a, b);
        long maxv = -1;
        while (D[b] > D[a]) {
            maxv = max(maxv, P[b][1]);
            b = P[b][0];
        }
        while (a != b) {
            maxv = max(maxv, P[a][1]);
            a = P[a][0];
            maxv = max(maxv, P[b][1]);
            b = P[b][0];
        }
        writeln(mst_cost - maxv);
    }
}
