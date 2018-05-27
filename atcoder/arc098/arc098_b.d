import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    long ans = N;
    int left = 0;
    long xxx = 0;

    foreach (i; 0..N) {
        while (left < i && (xxx + A[i] != (xxx ^ A[i]))) {
            xxx ^= A[left];
            left += 1;
        }
        xxx ^= A[i];
        ans += i - left;
    }

    ans.writeln;
}
