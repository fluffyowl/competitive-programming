import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = M.iota.map!(_ => readln.split.map!(to!int).array).array;
    A.sort!"a[0] == b[0] ? a[1] > b[1] : a[0] < b[0]";

    auto dp = new int[](N+1);
    dp.fill(1<<30);
    dp[0] = 0;

    foreach (i; 0..M) {
        foreach (j; A[i][0]..A[i][1]+1) {
            dp[j] = min(dp[j], dp[A[i][0]-1] + 1);
        }
    }

    writeln(dp[N] >= 1<<30 ? "Impossible" : dp[N].to!string);
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = M.iota.map!(_ => readln.split.map!(to!int).array).array;
    A.sort!"a[0] == b[0] ? a[1] > b[1] : a[0] < b[0]";

    auto dp = new int[](N+1);
    dp.fill(1<<30);
    dp[0] = 0;

    foreach (i; 0..M) {
        foreach (j; A[i][0]..A[i][1]+1) {
            dp[j] = min(dp[j], dp[A[i][0]-1] + 1);
        }
    }

    writeln(dp[N] >= 1<<30 ? "Impossible" : dp[N].to!string);
}
