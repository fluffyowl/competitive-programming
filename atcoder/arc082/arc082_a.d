import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto C = new int[](101010);

    foreach (i; 0..N)
        C[A[i]] += 1;

    int ans = 0;
    foreach (i; 0..100100) {
        if (i == 0)
            ans = max(ans, C[0] + C[1]);
        else
            ans = max(ans, C[i-1] + C[i] + C[i+1]);
    }

    ans.writeln;
}
