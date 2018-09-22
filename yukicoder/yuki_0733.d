import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto T = readln.chomp.to!int;
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;

    auto mem = new int[](1 << N);
    fill(mem, -1);

    auto cost = (1 << N).iota.map!(mask => N.iota.filter!(i => (1 << i) & mask).map!(i => A[i]).sum).array;

    int dfs(int mask) {
        if (mask == 0) return 0;
        if (mem[mask] >= 0) return mem[mask];

        int ret = 1 << 29;
        for(int nmask = mask; nmask > 0; nmask = (nmask-1) & mask) {
            if (cost[nmask] <= T) {
                ret = min(ret, dfs(mask ^ nmask) + 1);
            }
        }

        mem[mask] = ret;
        return ret;
    }

    dfs((1 << N) - 1).writeln;
}

