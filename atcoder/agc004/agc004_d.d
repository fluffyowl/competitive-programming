import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!int).array;
    auto edges = new int[][](N);
    foreach (i; 1..N) {
        auto a = A[i] - 1;
        auto b = i;
        edges[a] ~= b;
        edges[b] ~= a;
    }
    
    auto depth = new int[](N);
    void dfs(int n, int p, int d) {
        depth[n] = d;
        foreach (m; edges[n]) if (m != p) dfs(m, n, d + 1);
    }
    dfs(0, -1, 0);


    auto used = new bool[](N);
    void dfs2(int n, int lb, int ub) {
        used[n] = true;
        foreach (m; edges[n]) if (depth[m] >= lb && depth[m] <= ub && !used[m]) dfs2(m, lb, ub);
    }

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int)), "a[1] < b[1]");
    foreach (i; 1..N) if (depth[i] > K) pq.insert(tuple(i, depth[i]));
    int ans = A[0] != 1;

    while (!pq.empty) {
        auto t = pq.front;
        auto n = t[0];
        pq.popFront;
        if (used[n]) continue;
        ans += 1;
        dfs2(n, min(depth[n], depth[n] - K + 1), depth[n]);
    }

    ans.writeln;
}
