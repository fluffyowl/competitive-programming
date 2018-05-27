#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

int T[20][2]; 
int G[20];
int dp[1<<20][21][2];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    const int INF = 1 << 29;

    int N, M, C, D;
    cin >> N >> M >> C >> D;
    REP(i, N) REP(j, 2) cin >> T[i][j];
    REP(i, M) {
        int a, b; cin >> a >> b; --a; --b;
        G[b] |= (1 << a);
    }

    for (int i = 0; i < (1<<N); ++i)
        for (int j = 0; j < N; ++j)
            for (int k = 0; k < 2; ++k)
                dp[i][j][k] = INF;
    dp[0][0][0] = dp[0][0][1] = 0;
    
    for (int mask = 0; mask < (1 << N); ++mask) {
        for (int i = 0; i < N; ++i) {
            for (int a = 0; a < 2; ++a) {
                if (dp[mask][i][a] == INF) continue;
                for (int j = 0; j < N; ++j) {
                    if (mask & (1 << j)) continue;
                    if ((mask & G[j]) != G[j]) continue;
                    for (int b = 0; b < 2; ++b) {
                        if (a == b) {
                            dp[mask|(1<<j)][i][b] = min(dp[mask|(1<<j)][i][b],
                                                        dp[mask][i][a] + T[j][b]);
                        } else if (i < N-1) {
                            dp[mask|(1<<j)][i+1][b] = min(dp[mask|(1<<j)][i+1][b],
                                                          dp[mask][i][a] + T[j][b] + C*i+D);
                        }
                    }
                }
            }
        }
    }

    int ans = INF;
    REP (i, N) REP(j, 2) ans = min(ans, dp[(1<<N)-1][i][j]);
    cout << ans << endl;
}
