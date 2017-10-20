import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.chomp;
    auto B = readln.chomp;

    bool[] tate;
    for (int i = 0; i < N; i++) {
        if (i == N - 1 || A[i] != A[i + 1]) tate ~= true;
        else tate ~= false, i += 1;
    }

    long ans = 1;
    long MOD = 10^^9 + 7;
    long a, b;

    for (int i = 0; i < tate.length; i++) {
        if (i == 0 && tate[i]) {
            a = 3;
            b = 1;
        } else if (i == 0 && !tate[i]) {
            a = 3;
            b = 2;
        } else if (tate[i] && tate[i-1]) {
            a = 2;
            b = 1;
        } else if (tate[i] && !tate[i-1]) {
            a = 1;
            b = 1;
        } else if (!tate[i] && tate[i-1]) {
            a = 2;
            b = 1;
        } else {
            a = 3;
            b = 1;
        }
        ans = ans * a * b % MOD;
    }

    ans.writeln;
}
