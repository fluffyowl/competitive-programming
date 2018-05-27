import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int - 1).array;
    auto B = new int[](N);
    foreach (i; 0..N) B[A[i]] = i;

    int ans = 1;
    int tmp = 1;
    foreach (i; 0..N-1) {
        if (B[i] < B[i+1])
            tmp++;
        else
            tmp = 1;
        ans = max(ans, tmp);
    }

    ans = N - ans;
    ans.writeln;
}
