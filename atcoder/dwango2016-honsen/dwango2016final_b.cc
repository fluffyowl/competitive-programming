#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

ll X[1010];
ll dp[1010][1010][2];

bool in_time(int i, long dist, ld vel) {
    return dist / vel <= abs(X[i]);
}

int main() {
    const ll INF = 1L << 59;

    int N; cin >> N;
    REP(i, N) cin >> X[i];

    ld hi = 1000000000000000.0;
    ld lo = 1.0;

    REP(_, 100) {
        ld mid = (hi + lo) / 2;
        REP(i, N) REP(j, N) REP(k, 2) dp[i][j][k] = INF;
        REP(i, N) dp[i][i][0] = dp[i][i][1] = abs(X[i]);

        REP2 (len, 1, N+1) REP(l, N) REP(i, 2) REP(j, 2) {
            int r = l + len - 1;
            int nl = l;
            int nr = r;
            if (j == 0) nl -= 1;
            else        nr += 1;
            if (nl < 0 || nr >= N) continue;

            if (i == 0 && j == 0) {
                ll nd = dp[l][r][i] + X[l] - X[nl];
                if (in_time(nl, nd, mid)) dp[nl][nr][j] = min(dp[nl][nr][j], nd);
            } else if (i == 0 && j == 1) {
                ll nd = dp[l][r][i] + X[nr] - X[l];
                if (in_time(nr, nd, mid)) dp[nl][nr][j] = min(dp[nl][nr][j], nd);
            } else if (i == 1 && j == 0) {
                ll nd = dp[l][r][i] + X[r] - X[nl];
                if (in_time(nl, nd, mid)) dp[nl][nr][j] = min(dp[nl][nr][j], nd);
            } else if (i == 1 && j == 1) {
                ll nd = dp[l][r][i] + X[nr] - X[r];
                if (in_time(nr, nd, mid)) dp[nl][nr][j] = min(dp[nl][nr][j], nd);
            }
        }

        if (min(dp[0][N-1][0], dp[0][N-1][1]) != INF) hi = mid;
        else lo = mid;
    }

    cout.precision(20);
    cout << fixed  << hi << endl;
}
