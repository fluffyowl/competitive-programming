import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new Tuple!(int, real)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[1]] ~= tuple(s[0], s[2]/100.0L);
    }

    real ans = 0;
    
    foreach (mask; 0..(1<<N)) {
        if ((mask & 1) == 0 || ((mask >> (N-1)) & 1) == 0)
            continue;
        real tmp = 1;
        foreach (u; 1..N) {
            real tmp2 = 1;
            foreach (to; G[u]) {
                int v = to[0];
                real p = to[1];
                tmp2 *= ((mask >> v) & 1) ? (1-p) : 1;
            }
            tmp2 = ((mask >> u) & 1) ? (1 - tmp2) : tmp2;
            tmp *= tmp2;
        }
        ans += tmp;
    }

    writefln("%.09f", ans);
}

