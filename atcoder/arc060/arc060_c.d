import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    immutable int M = 31;
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!int).array;
    auto L = readln.chomp.to!int;
    auto Q = readln.chomp.to!int;
    auto AB = Q.iota.map!(_ => readln.split.map!(to!int).array).array;


    auto doubling = new int[][](M, N);
    int r = -1;
    foreach (i; 0..N) {
        while (r < N - 1 && X[r+1] - X[i] <= L) r++;
        doubling[0][i] = r;
    }

    foreach (i; 1..M) {
        foreach (j; 0..N) {
            doubling[i][j] = doubling[i-1][doubling[i-1][j]];
        }
    }

    foreach (ab; AB) {
        ab.sort();
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        int ans = 0;
        while (true) {
            if (doubling[0][a] >= b) {
                ans += 1;
                break;
            }
            int i = -1;
            while (doubling[i+1][a] < b) i++;
            a = doubling[i][a];
            ans += (1 << i);
        }
        
        ans.writeln;
    }
}
