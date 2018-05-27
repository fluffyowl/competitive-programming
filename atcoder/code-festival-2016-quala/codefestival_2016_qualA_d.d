import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto s = readln.split.map!(to!int);
    auto R = s[0];
    auto C = s[1];
    auto N = readln.chomp.to!int;
    auto A = new Tuple!(int, long)[][](R);

    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        auto r = s[0] - 1;
        auto c = s[1] - 1;
        auto a = s[2].to!long;
        A[r] ~= tuple(c, a);
    }
    foreach (i; 0..R) A[i].sort!"a[0] < b[0]";

    auto G = new Tuple!(int, long)[][](C);

    foreach (i; 0..R) {
        foreach (j; 0..A[i].length.to!int-1) {
            G[A[i][j][0]] ~= tuple(A[i][j+1][0], A[i][j+1][1] - A[i][j][1]);
            G[A[i][j+1][0]] ~= tuple(A[i][j][0], A[i][j][1] - A[i][j+1][1]);
        }
    }

    auto used = new bool[](C);
    auto vals = new long[](C);

    bool dfs(int n, long x) {
        if (used[n]) return vals[n] == x;
        used[n] = true;
        vals[n] = x;
        foreach (m; G[n]) if (!dfs(m[0], x+m[1])) return false;
        return true;
    }

    foreach (i; 0..C) if (!used[i] && !dfs(i, 0)) {writeln("No"); return;}

    used.fill(false);
    auto mins = new long[](C);
    int[] g;

    long dfs2(int n, long x) {
        if (used[n]) return x;
        x = min(x, vals[n]);
        used[n] = true;
        g ~= n;
        foreach (m; G[n]) x = min(x, dfs2(m[0], x));
        return x;
    }

    foreach (i; 0..C) {
        if (used[i]) continue;
        g = [];
        auto m = dfs2(i, 1L<<59);
        foreach (j; g) mins[j] = m;
    }

    foreach (i; 0..R) {
        foreach (a; A[i]) {
            auto m = mins[a[0]];
            auto x = a[1] - (vals[a[0]] - mins[a[0]]);
            if (x < 0) {
                writeln("No");
                return;
            }
        }
    }

    writeln("Yes");
}
