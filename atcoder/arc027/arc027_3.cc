#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define ll long long

ll X, Y, N;
ll T[310], H[310];
ll mem[301][301][301];


ll dp(ll x, ll y, ll n) {
    if (n >= N || y == 0) return 0;
    if (mem[x][y][n] >= 0) return mem[x][y][n];

    ll ret = dp(x, y, n+1);
    if (T[n] - 1 <= x)
        ret = max(ret, dp(x-T[n]+1, y-1, n+1)+H[n]);
    else if (T[n] <= x + y)
        ret = max(ret, dp(0, y-T[n]+x, n+1)+H[n]);

    return mem[x][y][n] = ret;
}

int main() {
    cin >> Y >> X >> N;
    REP(i, N) cin >> T[i] >> H[i];
    REP(i, X+1) REP(j, Y+1) REP(k, N) mem[i][j][k] = -1;

    cout << dp(X, Y, 0) << endl;
}
