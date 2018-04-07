import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    long ans = 0;

    if (K == 0) {
        writeln(1L * N * N);
        return;
    }
    
    foreach (b; K+1..N+1) {
        int M = N / b + (N % b > 0);
        ans += (b - K) * M;
        if (N % b != 0) ans -= min(b - K, M * b - N - 1);
    }

    ans.writeln;
}
