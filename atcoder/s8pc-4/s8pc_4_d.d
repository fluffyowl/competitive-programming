import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

int N;
int[][] adj;
int[] parent;
real[] ex, ans;

real dfs(int n, int prev) {
    parent[n] = prev;
    if (adj[n].length == 1 && prev != -1) return ex[n] = 0;
    real ret = 0;
    real num = adj[n].length.to!real;
    if (prev != -1) num -= 1;

    foreach (m; adj[n]) {
        if (m == prev) continue;
        ret += dfs(m, n) + 1;
    }

    return ex[n] = ret / num;
}

void dfs2(int n, int prev) {
    if (prev == -1) {
        ans[n] = ex[n];
    }
    else if (adj[n].length > 1 && adj[prev].length > 1) {
        ans[n] = ex[n] * (adj[n].length.to!real - 1) / (adj[n].length.to!real);
        ans[n] += ((ans[prev] - (ex[n]+1) / adj[prev].length) * adj[prev].length / (adj[prev].length - 1) + 1) / adj[n].length;
    }
    else if (adj[n].length > 1) {
        ans[n] = ex[n] * (adj[n].length.to!real - 1) / (adj[n].length.to!real);
        ans[n] += 1.0L / adj[n].length;
    }
    else {
        ans[n] += ((ans[prev] - (ex[n]+1) / adj[prev].length) * adj[prev].length / (adj[prev].length - 1) + 1) / adj[n].length;
        //ans[n] += (ans[prev] - (ex[n]) / (adj[prev].length.to!real) + 1) / adj[n].length;
    }

    foreach (m; adj[n]) {
        if (m != prev) dfs2(m, n);
    }
}


void main() {
    auto N = readln.chomp.to!int;
    adj = new int[][](N);
    parent = new int[](N);
    ex = new real[](N);
    ans = new real[](N);
    fill(ex, 0);
    fill(ans, 0);

    foreach (i; 0..N-1) {
        auto s = readln.split.map!(x => x.to!int - 1);
        adj[s[0]] ~= s[1];
        adj[s[1]] ~= s[0];
    }

    dfs(0, -1);
    dfs2(0, -1);

    foreach (i; 0..N) writefln("%.9f", ans[i]);
}
