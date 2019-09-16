#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

ll N;
bool isP[1010101];

void solve() {
    cin >> N;

    isP[0] = isP[1] = false;
    REP2(i, 2, 1010101) isP[i] = true;
    vector<ll> P;
    ll pmax = 0;

    for (ll i = 2; i < 1010101; ++i) if (isP[i]) {
        if (i <= N) {
            P.push_back(i);
            pmax = max(pmax, i);
        }
        for (ll j = i + i; j < 1010101; j += i) {
            isP[j] = false;
        }
    }

    ll ans = 0;
    for (auto r: P) if (r * r <= 2 * pmax) {
        for (auto q: P) if (r * r - q >= 2 && r * r - q <= N && isP[r * r - q]) {
            ans += 1;
        }
    }
    cout << ans << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    solve();
}

