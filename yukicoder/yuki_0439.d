import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N;
string S;
int[][] adj;
long allC, allW;
long[] subC, subW;


Tuple!(long, long) dfs1(int n, int prev) {
    subC[n] += (S[n] == 'c');
    subW[n] += (S[n] == 'w');
    foreach (m; adj[n]) {
        if (m == prev) continue;
        auto t = dfs1(m, n);
        subC[n] += t[0];
        subW[n] += t[1];
    }
    return tuple(subC[n], subW[n]);
}

long dfs2(int n, int prev) {
    long ret = 0;
    if (S[n] == 'w') {
        foreach (m; adj[n]) {
            if (m == prev) {
                auto c = allC - subC[n];
                auto w = subW[n] - 1;
                ret += c * w;
            }
            else {
                ret += subC[m] * (allW-subW[m]-1);
            }
        }
    }

    foreach (m; adj[n]) {
        if (m == prev) continue;
        ret += dfs2(m, n);
    }

    return ret;
}


void main() {
    N = readln.chomp.to!int;
    S = readln.chomp;
    adj = new int[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        adj[s[0]-1] ~= s[1] - 1;
        adj[s[1]-1] ~= s[0] - 1;
    }
    subC = new long[](N);
    subW = new long[](N);
    fill(subC, 0);
    fill(subW, 0);

    dfs1(0, -1);
    allC = subC[0];
    allW = subW[0];

    dfs2(0, -1).writeln;
}

