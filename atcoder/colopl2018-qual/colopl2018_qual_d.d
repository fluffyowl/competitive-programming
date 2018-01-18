import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1].to!long;
    auto T = N.iota.map!(_ => readln.chomp.to!long).array;
    auto U = new int[](N);

    foreach (i; 0..N) 
        foreach (j; i..N) 
            if (T[j] - T[i] <= X) 
                U[i] = j;

    auto dp = new long[][](N, N);
    dp[0].fill(X);

    foreach (i; 0..N-1) {
        foreach (j; 0..N) {
            dp[i+1][j] = dp[i][j];
        }
        foreach (j; 0..N) {
            dp[i+1][U[j]] = max(dp[i+1][U[j]], dp[i][j] + min(X, T[U[j]] - T[j]));
            if (U[j] < N-1)
                dp[i+1][U[j]+1] = max(dp[i+1][U[j]+1], dp[i][j] + min(X, T[U[j]+1] - T[j]));
        }
    }

    dp.map!(d => d.reduce!max).each!writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1].to!long;
    auto T = N.iota.map!(_ => readln.chomp.to!long).array;
    auto U = new int[](N);

    foreach (i; 0..N) 
        foreach (j; i..N) 
            if (T[j] - T[i] <= X) 
                U[i] = j;

    auto dp = new long[][](N, N);
    dp[0].fill(X);

    foreach (i; 0..N-1) {
        foreach (j; 0..N) {
            dp[i+1][j] = dp[i][j];
        }
        foreach (j; 0..N) {
            dp[i+1][U[j]] = max(dp[i+1][U[j]], dp[i][j] + min(X, T[U[j]] - T[j]));
            if (U[j] < N-1)
                dp[i+1][U[j]+1] = max(dp[i+1][U[j]+1], dp[i][j] + min(X, T[U[j]+1] - T[j]));
        }
    }

    dp.map!(d => d.reduce!max).each!writeln;
}
