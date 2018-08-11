import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 100000000000000007;
immutable int SEG = 10^^5;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!int).array;

    int ans = 0;

    for (int left = 0, right = 0, k = !A[0]; left < N; ++left) {
        if (right < left)
            right = left, k = !A[left];
        while (right + 1 < N) {
            if (A[right + 1] == 1)
                ++right;
            else if (k < K)
                ++right, ++k;
            else
                break;
        }
        ans = max(right - left + 1, ans);
        k -= !A[left];
    }

    ans.writeln;
}
