import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    long tmp = 0;
    int l = 0;
    int ans = 0;
    foreach (r; 0..N) {
        tmp += A[r];
        while (tmp > N) {
            tmp -= A[l];
            l += 1;
        }
        if (tmp == N) ans += 1;
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    long tmp = 0;
    int l = 0;
    int ans = 0;
    foreach (r; 0..N) {
        tmp += A[r];
        while (tmp > N) {
            tmp -= A[l];
            l += 1;
        }
        if (tmp == N) ans += 1;
    }

    ans.writeln;
}
