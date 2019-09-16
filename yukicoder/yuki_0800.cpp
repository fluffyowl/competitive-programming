#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll M = 2000 * 2000;
ll N, D;
ll cnt[M*2+1];

void solve() {
    cin >> N >> D;

    ll ans = 0;
    REP2 (z, 1, N+1) REP2 (w, 1, N+1) cnt[z*z-w*w+M] += 1;
    REP2 (x, 1, N+1) REP2 (y, 1, N+1) {
        if (D - x*x - y*y < -M) continue;
        if (D - x*x - y*y >  M) continue;
        ans += cnt[D-x*x-y*y+M];
    }
    cout << ans << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    solve();
}
