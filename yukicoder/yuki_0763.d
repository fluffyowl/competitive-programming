import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    int ans = 0;
    auto D = N.iota.map!(i => G[i].length.to!int).array;
    auto used = new bool[](N);

    DList!int queue;
    foreach (i; 0..N) if (D[i] == 1) queue.insertBack(i);

    while (!queue.empty) {
        int u = queue.front;
        queue.removeFront;

        if (used[u]) continue;
        used[u] = true;
        ans += 1;
        if (D[u] == 0) continue;

        int v = G[u].filter!(v => !used[v]).front;
        used[v] = true;

        foreach (w; G[v]) {
            if (used[w]) continue;
            D[w] -= 1;
            if (D[w] <= 1) queue.insertBack(w);
        }
    }

    ans.writeln;
}

