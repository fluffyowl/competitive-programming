#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
typedef vector<int> VI;
typedef vector<ll> VL;

int N, C;
int L[55];
int W[55];
int dp[51][51][51][51];
bool ok[51][51][51][51];

bool is_kadomatsu(int a, int b, int c) {
    return a != b && b != c && c != a && ((a < b && b > c) || (a > b && b < c));
}

void solve() {
    cin >> N >> C;
    REP(i, N) cin >> L[i];
    REP(i, N) cin >> W[i];

    int ans = 0;
    ok[0][0][0][0] = true;

    REP(a, 50) REP(b, C) REP(c, N) REP(d, N) if (ok[a][b][c][d]) REP(e, N) if (b + W[e] <= C) {
        if (a == 1 && L[d] == L[e]) continue;
        if (a > 1 && !is_kadomatsu(L[c], L[d], L[e])) continue;
        dp[a+1][b+W[e]][d][e] = max(dp[a+1][b+W[e]][d][e], dp[a][b][c][d] + L[e]);
        ok[a+1][b+W[e]][d][e] = true;
    }

    REP2(a, 3, 51) REP(b, 51) REP(c, 51) REP(d, 51) ans = max(ans, dp[a][b][c][d]);
    cout << ans << endl;

}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}

