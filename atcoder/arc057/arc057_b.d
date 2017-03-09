import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


immutable long INF = 1L << 60;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;

    auto S = new long[](N);
    S[0] = A[0];
    foreach (i; 1..N) S[i] = S[i-1] + A[i];

    if (K == 0) {
        writeln(0);
        return;
    }

    // dp[i][j] : i日目までに機嫌よかった日数がj日のときの、勝ちの最小数
    auto dp = new long[][](N+1, N+1);
    foreach (i; 0..N) fill(dp[i], INF);
    dp[0][0] = 0;
    dp[0][1] = 1;

    foreach (i; 1..N) {
        dp[i][0] = 0;
        foreach (j; 1..N+1) {
            dp[i][j] = dp[i-1][j];

            long hi = K + 1;
            long lo = -1;
            while (hi - lo > 1) {
                long mid = (hi + lo) / 2;
                if (mid * S[i-1] > dp[i-1][j-1] * S[i])
                    hi = mid;
                else
                    lo = mid;
            }

            hi = max(hi, dp[i-1][j-1]);
            long least = K - (S[N-1] - S[i]);

            if (hi >= least && hi <= S[i] && hi <= K)
                dp[i][j] = min(dp[i][j], hi);

        }
    }

    //dp.writeln;

    for (int i = N; i >= 0; i--) {
        if (dp[N-1][i] < INF) {
            writeln(i);
            break;
        }
    }
}
