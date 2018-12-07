import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split;
    auto N = s[0].to!long;
    auto K = s[1].to!int;
    auto A = K.iota.map!(_ => readln.chomp.to!long).array;
    int ans = 0;
    bool[long] mem;

    foreach (mask; 0..(1<<K)) {
        long a = 1;
        foreach (i; 0..K) {
            if (mask & (1 << i)) {
                a *= A[i];
                if (a > N) break;
            }
        }
        if (a > N || (a in mem)) continue;
        mem[a] = true;
        foreach (i; 0..K) if (a % A[i] == 0) a /= A[i];
        if (a == 1) ans += 1;
    }

    ans.writeln;
}
