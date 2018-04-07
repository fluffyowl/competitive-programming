import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!(dchar[]);
    N.reverse;
    N ~= '0';
    
    auto dp = new int[][](N.length+1, 2);
    foreach (i; 0..N.length+1) dp[i].fill(INF);
    dp[0][0] = 0;

    foreach (i; 0..N.length) {
        foreach (j; 0..2) {
            int d = N[i] - '0';
            int x = INF;
            int y = INF;
            foreach (a; 0..10) {
                foreach (b; 0..10) {
                    if ((a - b - j + 10) % 10 != d) continue;
                    int c = a / 5 + a % 5 + b / 5 + b % 5;
                    if (a - j >= b) x = min(x, c);
                    else            y = min(y, c);
                }
            }
            dp[i+1][0] = min(dp[i+1][0], dp[i][j] + x);
            dp[i+1][1] = min(dp[i+1][1], dp[i][j] + y);
        }
    }

    dp[N.length][0].writeln;
}

