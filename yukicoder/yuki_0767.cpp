#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const ll MOD = 100000007;
const ll MAX = 200010;

int H, W, K;
vector<ll> P[22];
ll F[MAX];
ll all[1<<20];
ll any[1<<20];


ll powmod(ll a, ll x, ll m) {
    ll ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

ll comb(ll n, ll r) {
    if (n < r) return 0;
    return F[n] * powmod(F[n-r], MOD-2, MOD) % MOD * powmod(F[r], MOD-2, MOD) % MOD;
}


void solve() {
    cin >> H >> W >> K;
    REP(i, K) {
        P[i] = {0, 0, i};
        cin >> P[i][0] >> P[i][1];
    }

    F[0] = 1;
    REP2(i, 1, MAX) F[i] = F[i-1] * i % MOD;
    all[0] = comb(H+W, H);

    REP2(mask, 1, 1<<K) {
        vector<vector<ll>> A;
        A.push_back({0, 0, -1});
        A.push_back({H, W, -1});
        REP(i, K) if ((mask & (1<<P[i][2]))) A.push_back(P[i]);
        sort(A.begin(), A.end());

        ll tmp = 1;
        REP(i, (int)A.size()-1) {
            if (A[i][1] > A[i+1][1]) {
                tmp = 0;
                break;
            }
            tmp *= comb(A[i+1][0] - A[i][0] + A[i+1][1] - A[i][1], A[i+1][0] - A[i][0]);
            tmp %= MOD;
        }

        all[mask] = tmp;
    }

    REP(mask, 1<<K) {
        any[mask] = __builtin_popcount(mask) % 2 ? -all[mask] : all[mask];
    }

    REP(i, K) REP(mask, 1<<K) if (mask & (1 << i)) {
        any[mask] += any[mask ^ (1 << i)];
        any[mask] %= MOD;
    }

    REP(mask, 1<<K) {
        cout << (any[mask] % MOD + MOD) % MOD << "\n";
    }

}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}

