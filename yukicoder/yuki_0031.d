import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto V = s[1];
    auto C = readln.split.map!(to!long).array;

    if (N >= V) {
        C.sum.writeln;
        return;
    }

    long ans = C.sum;
    V -= N;

    auto P = new Tuple!(int, long)[](N);
    long c = C.sum;
    
    foreach_reverse (i; 0..N) {
        P[i] = tuple(i+1, c);
        c -= C[i];
    }

    if (V > 10000) {
        int VV = V - 10000;
        P.sort!"a[1]*b[0] < a[0]*b[1]";
        ans += P[0][1] * (VV / P[0][0]);
        VV %= P[0][0];
        V = 10000 + VV;
    }

    auto dp = new long[](10200);
    fill(dp, INF);
    dp[0] = 0;

    foreach (i; 0..N) {
        int v = P[i][0];
        long cost = P[i][1];
        foreach (j; 0..10200-v) {
            dp[j+v] = min(dp[j+v], dp[j] + cost);
        }
    }

    ans += dp[V..10200].reduce!min;
    ans.writeln;
}

