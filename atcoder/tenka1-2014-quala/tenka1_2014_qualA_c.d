import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = N.iota.map!(_ => readln.chomp).array;

    auto pair = new bool[][](N, N);

    foreach (i; 0..N)
        foreach (j; 0..N)
            pair[i][j] = true;

    foreach (i; 0..N)
        foreach (j; i+1..N)
            foreach (k; 0..M)
                if (S[i][k] != S[j][k] && S[i][k] != '*' && S[j][k] != '*')
                    pair[i][j] = pair[j][i] = false;


    auto mem = new int[](1 << N);
    fill(mem, -1);

    int dfs(int mask) {
        if (mem[mask] >= 0) return mem[mask];
        if (mask.popcnt == 1) return 1;

        bool ok = true;

        foreach (i; 0..N) {
            if (!((mask >> i) & 1))
                continue;
            foreach (j; i+1..N) {
                if (!((mask >> j) & 1))
                    continue;
                if (!pair[i][j])
                    ok = false;
            }
        }

        if (ok) {
            mem[mask] = 1;
            return 1;
        }

        int ret = 1 << 29;

        for(int i = mask; i > 0; i = (i - 1) & mask) {
            if (i == mask) continue;
            int comp = ~i & mask;
            ret = min(ret, dfs(i) + dfs(comp));
        }

        return mem[mask] = ret;
    }

    dfs((1 << N) - 1).writeln;
}
