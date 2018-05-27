import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    int[][int] A;
    int tmp = 0;
    A[0] ~= -1;

    foreach (i; 0..S.length) {
        if (S[i] == 'A') tmp += 1;
        else tmp -= 1;
        A[tmp] ~= i.to!int;
    }

    int ans = 0;
    foreach (k; A.keys) {
        if (A[k].length < 2) continue;
        ans = max(ans, A[k].back - A[k].front);
    }

    ans.writeln;
}

