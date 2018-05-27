import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new int[][](N);
    auto H = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        auto g = s[0] - 1;
        auto r = s[1];
        auto hh = readln.split.map!(to!int).array;
        foreach (h; hh) G[g] ~= h-1, H[h-1] ~= g;
    }

    auto D = new int[](N);
    foreach (i; 0..N) D[i] = G[i].length.to!int;

    int p = 0;
    auto stack = new int[](N);
    foreach (i; 0..N) if (D[i] == 0) stack[p++] = i;
    auto used = new bool[](N);
    int ans = 0;

    while (p > 0) {
        auto n = stack[--p];
        if (used[n]) continue;
        ans += 1;
        used[n] = true;
        foreach (m; H[n]) {
            D[m] -= 1;
            if (D[m] == 0 && !used[m]) stack[p++] = m;
        }
    }

    ans.writeln;
}

