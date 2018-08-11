import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto dp = new Tuple!(long, long)[][](1<<N, 2);

    foreach (i; 0..(1<<N)) {
        if (A[i] >= dp[i][0][0]) {
            dp[i][1] = dp[i][0];
            dp[i][0] = tuple(A[i], i);
        } else if (A[i] >= dp[i][1][0]) {
            dp[i][1] = tuple(A[i], i);
        }
        foreach (j; 0..N) {
            if ((i >> j) & 1) continue;
            auto hoge = [dp[i][0], dp[i][1], dp[i|(1<<j)][0], dp[i|(1<<j)][1]];
            hoge = hoge.sort!"a > b".uniq().array;
            dp[i|(1<<j)][0] = hoge[0];
            dp[i|(1<<j)][1] = hoge[1];
        }
    }

    long ans = 0;
    foreach (i; 1..(1<<N)) {
        ans = max(ans, dp[i][0][0] + dp[i][1][0]);
        ans.writeln;
    }
}
