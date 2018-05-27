import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable int M = 30;
    
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(to!int).array;
    
    auto B_bits = new int[][](M);
    foreach (i; 0..N) foreach (j; 0..M) B_bits[j] ~= (B[i] & ((1<<(j+1))-1));
    foreach (j; 0..M) B_bits[j].sort();

    int ans = 0;
    
    foreach (i; 0..N) {
        foreach (j; 0..M) {
            int a = A[i] & ((1 << (j + 1)) - 1);
            int x = ((1 << j) - 1) - (a & ((1 << j) - 1)) + 1;
            int y = x + (1 << j);
            int lb = B_bits[j].assumeSorted.lowerBound(x).length.to!int;
            int ub = B_bits[j].assumeSorted.upperBound(y-1).length.to!int;
            int one = lb + ub;
            if ((a >> j) == 0) one = N - one;
            one &= 1;
            ans ^= (one << j);
        }
    }

    ans.writeln;
}
