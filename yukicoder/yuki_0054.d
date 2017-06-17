import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "v", int, "t") Okashi;

void main() {
    auto N = readln.chomp.to!int;
    auto K = new Okashi[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        K[i] = Okashi(s[0], s[1]);
    }
    K.sort!"a.v + a.t < b.v + b.t"();

    auto dp = new bool[](10001);
    dp[0] = true;

    int ans = 0;
    
    foreach (i; 0..N) {
        foreach (j; iota(K[i].t-1, -1, -1)) {
            if (dp[j]) {
                ans = max(ans, j + K[i].v);
                if (j + K[i].v <= 10000) {
                    dp[j + K[i].v] = true;
                } 
            }
        }
    }


    ans.writeln;
}

