import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    auto next = new int[][](26, N);
    foreach (i; 0..26) fill(next[i], -1);

    foreach (c; 0..26) {
        for (int i = N - 1; i >= 0; i--) {
            if (S[i] - 'a' == c) {
                next[c][i] = i + 1;
            } else if (i < N - 1) {
                next[c][i] = next[c][i+1];
            }
        }
    }

    auto mem = new Tuple!(int, int)[](N);
    fill(mem, tuple(1 << 29, 1 << 29));

    Tuple!(int, int) dfs(int n) {
        if (n == -1) return tuple(0, -1);
        if (n >= N) return tuple(1, -1);
        if (mem[n][0] != 1 << 29) return mem[n];
        auto ret = tuple(1 << 29, 1 << 29);
        foreach (i; 0..26) {
            auto t = dfs(next[i][n]);
            if (t[0] < ret[0]) ret = tuple(t[0], i);
        }
        mem[n] = tuple(ret[0] + 1, ret[1]);
        return mem[n];
    }

    dfs(0);
    string ans = "";

    for (int i = 0; i != -1;) {
        if (mem[i][1] == -1) break;
        char c = (mem[i][1].to!char + 'a').to!char;
        ans ~= c;
        i = next[c - 'a'][i];
    }

    ans.writeln;
}
