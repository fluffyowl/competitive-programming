import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

long[Tuple!(long, long)] mem;
immutable long MOD = 10^^9 + 7;

long dp(long s, long x) {
    Tuple!(long, long) t = tuple(s, x);
    if (t in mem)
        return mem[t];
    if (s == 0)
        return 1;
    else if (s == 1) {
        mem[t] = (dp(s/2, x/2) + dp((s-1)/2, (x-1)/2)) % MOD;
        return mem[t];
    }
    mem[t] = (dp(s/2, x/2) + dp((s-1)/2, (x-1)/2) + dp((s-2)/2, x/2)) % MOD;
    return mem[t];
}

void main() {
    long N = readln.chomp.to!long;
    dp(N, N).writeln;
}
