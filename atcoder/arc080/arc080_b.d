import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    auto ans = new int[][](H, W);
    int p = 0;

    foreach (i; 0..H) {
        foreach (jj; 0..W) {
            int j = jj;
            if (i % 2 == 1) j = W - jj - 1;
            if (A[p] == 0) p++;
            ans[i][j] = p + 1;
            A[p] -= 1;
        }
    }

    foreach (i; 0..H) ans[i].map!(a => a.to!string).join(" ").writeln;
}
