import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;

    long[long] g;
    foreach (a; A) g[gcd(a, K)] += 1;
    
    long ans = 0;
    foreach (i; g.keys) {
        foreach (j; g.keys) {
            if (i * j % K == 0) ans += g[i] * g[j];
        }
    }

    foreach (a; A) if (a * a % K == 0) ans -= 1;

    writeln(ans/2);
}
