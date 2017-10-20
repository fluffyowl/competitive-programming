import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!int).array;
    
    auto numbers = new int[](N + 1);
    auto segment = new int[](N);

    foreach (a; A) numbers[a] += 1;
    foreach (i; 1..N+1) {
        if (numbers[i] == 0) continue;
        foreach (j; 0..numbers[i]) {
            if (i - j - 1 < 0) break;
            segment[i - j- 1] += 1;
        }
    }

    int ans = segment.map!(x => x == 0).sum;

    while (M--) {
        s = readln.split.map!(to!int);
        auto X = s[0] - 1;
        auto Y = s[1];
        if (A[X] != Y) {
            int a = A[X] - (numbers[A[X]]);
            int b = Y - (numbers[Y] + 1);
            if (a != b && a >= 0 && segment[a] == 1) ans += 1;
            if (a != b && b >= 0 && segment[b] == 0) ans -= 1;
            numbers[A[X]] -= 1;
            numbers[Y] += 1;
            A[X] = Y;
            if (a >= 0) segment[a] -= 1;
            if (b >= 0) segment[b] += 1;
        }
        ans.writeln;
    }
}
