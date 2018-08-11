import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto dp = new long[](1<<N);
    auto bits = (1<<N).iota.array;

    foreach (mask; 0..(1<<N))
        foreach (i; 0..N) 
            foreach (j; i+1..N) 
                if (!((1<<i)&mask) && !((1<<j)&mask))
                    dp[mask|(1<<i)|(1<<j)] = max(dp[mask|(1<<i)|(1<<j)], dp[mask] + (A[i]^A[j]));

    dp[(1<<N)-1].writeln;
}

