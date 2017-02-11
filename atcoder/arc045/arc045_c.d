import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "to", long, "cost") Edge;
int N, x, y;
long X, c;
Edge[][] adj;
long[] xorsum;

void dfs(int n, int prev) {
    foreach (m; adj[n]) {
        if (m.to == prev) continue;
        xorsum[m.to] = xorsum[n] ^ m.cost;
        dfs(m.to, n);
    }
}

void main() {
    scanf("%d %lld", &N, &X);
    xorsum = new long[](N);
    adj = new Edge[][](N);
    foreach (i; 0..N-1) {
        scanf("%d %d %lld", &x, &y, &c);
        adj[x-1] ~= Edge(y-1, c);
        adj[y-1] ~= Edge(x-1, c);
    }

    dfs(0, -1);

    long[long] cnt;
    long ans = 0;
    foreach (i; 0..N) {
        long x = xorsum[i];
        if ((X^x) in cnt) ans += cnt[X^x];
        if (x in cnt) cnt[x] += 1;
        else cnt[x] = 1;
    }

    ans.writeln;
}
