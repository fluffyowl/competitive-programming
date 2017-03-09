import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int N;
long K;
long[][] W;
long[] SW;
long[] mem;


long dp(int mask) {
    if (mask == 0)
        return 0;
    if (mem[mask] >= 0)
        return mem[mask];
    
    long ret = 0;
    
    for(int i = mask; i > 0; i = (i-1) & mask) {
        long tmp = K - (SW[mask] - SW[i] - SW[mask^i]);
        tmp += dp(mask^i);
        ret = max(ret, tmp);
    }

    return mem[mask] = ret;
}



void main() {
    auto s = readln.split;
    N = s[0].to!int;
    K = s[1].to!long;
    W = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    mem = new long[](1 << 17);
    fill(mem, -1);

    SW = new long[](1 << N);
    fill(SW, 0);
    foreach (mask; 0..(1 << N)) {
        foreach (i; 0..N) {
            foreach (j; i+1..N) {
                auto a = (1 << i) & mask;
                auto b = (1 << j) & mask;
                if (a && b) {
                    SW[mask] += W[i][j];
                }
            }
        }
    }


    dp((1 << N) - 1).writeln;
}
