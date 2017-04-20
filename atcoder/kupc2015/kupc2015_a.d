import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto T = readln.chomp.to!int;
    while(T--) {
        auto S = readln.chomp;
        auto N = S.length.to!int;
        auto ans = 0;
        auto p = 0;
        while (p < N-4) {
            if (S[p..p+5] == "tokyo" || S[p..p+5] == "kyoto") {
                ans += 1;
                p += 5;
            }
            else {
                p += 1;
            }
        }
        ans.writeln;
    }
}
