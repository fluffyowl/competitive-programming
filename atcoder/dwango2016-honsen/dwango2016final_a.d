import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    immutable long INF = 10L^18+10;
    auto N = readln.chomp.to!long;

    long[] nico;
    for (long a = 2; a <= N; a = (a % 10 == 2) ? a * 10 + 5 : a * 10 + 2) nico ~= a;
    for (long a = 5; a <= N; a = (a % 10 == 2) ? a * 10 + 5 : a * 10 + 2) nico ~= a;
    auto M = nico.length.to!int;

    long[long] mem;

    long dfs(long n) {
        if (n in mem) return mem[n];
        if (n == 1) return 1;
        if (n == 0) return 0;
        long ret = INF;
        foreach (x; nico) ret = min(ret, dfs(n/x) + n%x);
        mem[n] = ret;
        return mem[n];
    }

    dfs(N).writeln;
}
