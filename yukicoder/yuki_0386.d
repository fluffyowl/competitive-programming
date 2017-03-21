import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int MAX = 20;

int N, M;
int[] depth;
int[][] adj, doubling;
long[] U, cost;

void dfs(int n, int prev, long c, int d) {
    doubling[n][0] = prev;
    cost[n] = c + U[n];
    depth[n] = d + 1;
    foreach (m; adj[n]) if (m != prev) dfs(m, n, cost[n], d+1);
}

int lca(int a, int b) {
    if (a == b) return a;
    
    if (depth[b] < depth[a]) swap(a, b);
    int diff = depth[b] - depth[a];
    foreach (i; 0..MAX) {
        if ((1 << i) & diff)
            b = doubling[b][i];
    }

    while (a != b) {
        foreach (i; 0..MAX-1) {
            if (doubling[a][i+1] == doubling[b][i+1]) {
                a = doubling[a][i];
                b = doubling[b][i];
                break;
            }
        }
    }

    return a;
}


void main() {
    N = readln.chomp.to!int;
    adj = new int[][](N);
    U = new long[](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        adj[s[0]] ~= s[1];
        adj[s[1]] ~= s[0];
    }
    foreach (i; 0..N) {
        U[i] = readln.chomp.to!long;
    }
    M = readln.chomp.to!int;


    cost = new long[](N);
    depth = new int[](N);
    doubling = new int[][](N, MAX);
    dfs(0, -1, 0, -1);
    fill(doubling[0], -1);
    foreach (j; 1..MAX) {
        foreach (i; 1..N) {
            doubling[i][j] = doubling[max(0, doubling[i][j-1])][j-1];
        }
    }

    long ans = 0;
    foreach (i; 0..M) {
        auto s = readln.split;
        auto a = s[0].to!int;
        auto b = s[1].to!int;
        auto c = s[2].to!long;
        auto d = lca(a, b);
        ans += (cost[a] + cost[b] - 2 * cost[d] + U[d]) * c;
    }
    ans.writeln;
}

