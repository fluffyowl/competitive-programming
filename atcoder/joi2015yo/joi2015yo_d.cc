#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;
const ll INF = 1LL << 59;

ll dp[1010][1010];
ll C[1010];
ll D[1010];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    int N, M;
    cin >> N >> M;
    REP(i, N) cin >> D[i];
    REP(i, M) cin >> C[i];
    REP(i, N+1) REP(j, M+1) dp[i][j] = i == 0 ? 0 : INF;

    REP(i, N) {
        REP(j, M) dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j] + C[j] * D[i]);
        REP(j, M) dp[i+1][j+1] = min(dp[i+1][j+1], dp[i+1][j]);
    }

    ll ans = INF;
    REP(i, M+1) ans = min(ans, dp[N][i]);
    cout << ans << endl;
}
