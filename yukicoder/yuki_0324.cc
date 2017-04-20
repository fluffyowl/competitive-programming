#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

const int INF = 1 << 29;
int N, M;
int W[3010];
int dp[3010][3010][2][2];

int main() {
    cin >> N >> M;
    REP(i, N) cin >> W[i];

    if (M == 0) {
      cout << 0 << endl;
      return 0;
    }

    REP(i, N+1) REP(j, M+1) REP(k, 2) REP(l, 2) dp[i][j][k][l] = -INF;
    dp[0][0][0][0] = 0;
    dp[0][1][1][1] = 0;

    REP2(i, 1, N) REP(j, M+1) REP(k, 2) REP(l, 2) {
        if (dp[i-1][j][k][l] == -INF) continue;
        int take = 0;
        if (k) take += W[i-1];
        if (i == N-1 && l) take += W[N-1];

        if (j < M) dp[i][j+1][1][l] =
                       max(dp[i][j+1][1][l], dp[i-1][j][k][l] + take);
        dp[i][j][0][l] = max(dp[i][j][0][l], dp[i-1][j][k][l]);
    }

    int ans = -INF;
    REP(k, 2) REP(l, 2) ans = max(ans, dp[N-1][M][k][l]);
    cout << ans << endl;
}

