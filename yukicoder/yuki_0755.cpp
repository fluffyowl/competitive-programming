#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

int N, M;
ll A[150][150];

ll sm(int r1, int c1, int r2, int c2) {
    return A[r2+1][c2+1] - A[r1][c2+1] - A[r2+1][c1] + A[r1][c1];
}

void solve() {
    cin >> N >> M;
    REP(i, M) REP(j, M) cin >> A[i+1][j+1];

    REP(i, M+1) REP(j, M) A[i][j+1] += A[i][j];
    REP(j, M+1) REP(i, M) A[i+1][j] += A[i][j];

    while (N--) {
        int r, c; cin >> r >> c; --r, --c;
        ll ans = 0;
        REP(r1, r+1) REP(c1, c+1) REP2(r2, r, M) REP2(c2, c, M) ans += !sm(r1, c1, r2, c2);
        cout << ans << "\n";
    }
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}

