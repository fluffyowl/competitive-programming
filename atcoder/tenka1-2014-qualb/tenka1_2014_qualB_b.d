import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto T = N.iota.map!(_ => readln.chomp).array;
    auto M = S.length.to!int;

    auto mem = new long[](M);
    mem.fill(-1);
    
    long dfs(int n) {
        if (n >= M) return 1;
        if (mem[n] >= 0) return mem[n];

        long ret = 0;
        
        foreach (i; 0..N) 
            if (S[n..$].startsWith(T[i])) 
                ret = (ret + dfs(n + T[i].length.to!int)) % MOD;

        mem[n] = ret;
        return mem[n];
    }

    dfs(0).writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto T = N.iota.map!(_ => readln.chomp).array;
    auto M = S.length.to!int;

    auto mem = new long[](M);
    mem.fill(-1);
    
    long dfs(int n) {
        if (n >= M) return 1;
        if (mem[n] >= 0) return mem[n];

        long ret = 0;
        
        foreach (i; 0..N) 
            if (S[n..$].startsWith(T[i])) 
                ret = (ret + dfs(n + T[i].length.to!int)) % MOD;

        mem[n] = ret;
        return mem[n];
    }

    dfs(0).writeln;
}
