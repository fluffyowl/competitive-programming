import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable real INF = 1L << 59;
    
    auto N = readln.chomp.to!int;
    auto T = new long[](N);
    auto X = new long[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        T[i] = s[0];
        X[i] = s[1];
    }

    real hi = 10^^9;
    real lo = 0;
    foreach (_; 0..100) {
        real mid = (hi + lo) / 2;
        auto dp = new Tuple!(real, real)[](N+1);
        foreach (i; 0..N+1) dp[i] = tuple(INF, -INF);
        dp[0] = tuple(0.0L, 0.0L);
        real prev_t = 0;
        real prev_x = 0;
        foreach (i; 0..N) {
            if (dp[i][0] > dp[i][1])
                break;
            real t = T[i] - prev_t;
            real x = abs(X[i] - prev_x);
            if (x <= mid * t) {
                dp[i+1][0] = min(dp[i+1][0], dp[i][0] - t * mid);
                dp[i+1][1] = max(dp[i+1][1], dp[i][1] + t * mid);
            }
            if (dp[i][0] - t * mid <= X[i] && X[i] <= dp[i][1] + t * mid) {
                dp[i+1][0] = min(dp[i+1][0], prev_x - t * mid);
                dp[i+1][1] = max(dp[i+1][1], prev_x + t * mid);
            }
            prev_t = T[i];
            prev_x = X[i];
        }
        (dp[N][0] <= dp[N][1] ? hi : lo) = mid;
    }

    writefln("%.09f", hi);
}
