import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto A = new long[][](N, 3);

    foreach (i; 0..N) {
        if (i > 0) foreach (j; 0..3) A[i][j] = A[i-1][j];
        if (S[i] == '(') A[i][2] += 1;
        else if (S[i] == ')' && A[i][2] > 0) A[i][2] -= 1, A[i][1] += 1;
        else A[i][0] += 1;
    }

    long ans = 0;
    foreach (i; 0..N) ans += A[i][1] * 2;

    A.sort!((a, b) => min(a[2], b[0]) > min(a[0], b[2]));
    long a = 0;
    foreach (i; 0..N) {
        long m = min(a, A[i][0]);
        ans += m * 2;
        a -= m;
        a += A[i][2];
    }

    ans.writeln;
}

