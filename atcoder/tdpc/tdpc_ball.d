import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!int).array;


    auto mem = new real[](1 << 16);
    mem.fill(-1);

    real dfs(int mask) {
        if (mem[mask] >= 0)
            return mem[mask];
        if (mask == 0)
            return 0;

        real ret = 1L << 59;

        foreach (i; 1..15) {
            int b = (mask & (0b111 << (i - 1))) >> (i - 1);
            int nmask = mask & ~(0b111 << (i - 1));
            real tmp = 1L << 59;
            
            if (b == 0b111) {
                tmp =
                    dfs(nmask | (0b011 << (i - 1))) / 3 +
                    dfs(nmask | (0b101 << (i - 1))) / 3 +
                    dfs(nmask | (0b110 << (i - 1))) / 3 + 1;
            } else if (b == 0b011) {
                tmp =
                    dfs(nmask | (0b001 << (i - 1))) / 2 +
                    dfs(nmask | (0b010 << (i - 1))) / 2 + 1.5L;
            } else if (b == 0b101) {
                tmp =
                    dfs(nmask | (0b001 << (i - 1))) / 2 +
                    dfs(nmask | (0b100 << (i - 1))) / 2 + 1.5L;
            } else if (b == 0b110) {
                tmp =
                    dfs(nmask | (0b010 << (i - 1))) / 2 +
                    dfs(nmask | (0b100 << (i - 1))) / 2 + 1.5L;
            } else if (b.popcnt == 1) {
                tmp = dfs(nmask) + 3.0L;
            }
            
            ret = min(ret, tmp);
        }

        mem[mask] = ret;
        return ret;
    }

    
    int mask = 0;
    foreach (x; X)
        mask |= (1 << x);
    writefln("%.9f", dfs(mask));
}
