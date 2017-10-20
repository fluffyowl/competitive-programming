import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;
     
void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto dp = new int[][][](N + 1, N + 1, N + 1);
    foreach (i; 0..N+1) foreach (j; 0..N+1) fill(dp[i][j], 1 << 29);
    dp[0][1][0] = S[0] == ')';

    
    foreach (i; 0..N-1) {
        foreach (j; 0..i+2) {
            foreach (k; 0..i+1) {
                // open
                if (S[i+1] == '(')
                    dp[i+1][j+1][k] = min(dp[i+1][j+1][k], dp[i][j][k]);
                else
                    dp[i+1][j+1][i+1] = min(dp[i+1][j+1][i+1], dp[i][j][k] + i + 1 - k + 1);
                // close
                if (S[i+1] == '(' && j > 0)
                    dp[i+1][j-1][i+1] = min(dp[i+1][j-1][i+1], dp[i][j][k] + i + 1 - k + 1);
                else if (S[i+1] == ')' && j > 0)
                    dp[i+1][j-1][k] = min(dp[i+1][j-1][k], dp[i][j][k]);
            }
        }
    }

    dp[N-1][0].reduce!min.writeln;
}
