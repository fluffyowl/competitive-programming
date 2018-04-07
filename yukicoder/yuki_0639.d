import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!long;
    long[long] mem;

    long dfs(long n) {
        if (n in mem) return mem[n];
        if (n == 0) return 1;
        mem[n] = dfs(n/3) + dfs(n/5);
        return mem[n];
    }

    dfs(N).writeln;
}

