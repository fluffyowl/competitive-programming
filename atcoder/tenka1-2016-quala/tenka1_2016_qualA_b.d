import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (i; 1..N) {
        auto p = readln.chomp.to!int;
        edges[i] ~= p;
        edges[p] ~= i;
    }
    auto C = new int[](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        C[s[0]] = s[1];
    }

    int ans = 0;
    
    int dfs(int n, int p) {
        int[] ret;
        foreach (m; edges[n]) {
            if (m == p) continue;
            ret ~= dfs(m, n);
        }

        if (ret.length == 0) {
            return C[n];
        } else if (n == 0) {
            ans += ret.sum;
            return 0;
        } else {
            auto mn = ret.reduce!min;
            ans += ret.map!(a => a - mn).sum;
            return mn;
        }
    }

    dfs(0, -1);
    ans.writeln;
}
