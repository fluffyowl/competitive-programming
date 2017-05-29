import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    immutable int INF = 2 * 10^^9;
    
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int);

    if (N == 1) {
        writeln(A[0]);
        return;
    }

    /*
      dp[l][r][left or right]: 
      未訪問の区間がl~rで、最後に訪問済のノードが l-1 or r+1 のときの最小コスト
     */
    auto dp = new int[][][](N, N, 2);
    foreach (i; 0..N) foreach (j; 0..N) fill(dp[i][j], INF);
    dp[1][N-1][0] = A[0];
    dp[0][N-2][1] = A[N-1];

    foreach (len; iota(N-1, 1, -1)) {
        foreach (i; 0..N-len+1) {
            int j = i + len - 1;
            int ltol = max(dp[i][j][0] + 1, A[i]);
            int rtol = max(dp[i][j][1] + j - i, A[i]);
            int ltor = max(dp[i][j][0] + j - i, A[j]);
            int rtor = max(dp[i][j][1] + 1, A[j]);
            dp[i+1][j][0] = min(dp[i+1][j][0], min(ltol, rtol));
            dp[i][j-1][1] = min(dp[i][j-1][1], min(ltor, rtor));
        }
    }

    
    int ans = INF;
    foreach (i; 0..N) {
        ans = min(ans, max(dp[i][i][0]+1, A[i]));
        ans = min(ans, max(dp[i][i][1]+1, A[i]));
    }

    ans.writeln;
}

