#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const ll MOD = 1000000007;
vector<int> G[201010];
int depth[201010];
ll p2[201010];
deque<vector<ll>> dp[201010];

void dfs(int n, int d) {
    depth[d] += 1;
    dp[n].resize(0);
    
    for (auto m: G[n]) {
        dfs(m, d+1);
        if (dp[n].size() < dp[m].size())
            swap(dp[n], dp[m]);
    }

    int maxd = 0;
    for (auto m: G[n]) {
        maxd = max(maxd, (int)dp[m].size());
        REP(i, (int)dp[m].size()) {
            ll v[3] = {};
            REP(a, 3) REP(b, 3)
                (v[min(2, a+b)] += dp[n][i][a] * dp[m][i][b] % MOD) %= MOD;
            dp[n][i][0] = v[0];
            dp[n][i][1] = v[1];
            dp[n][i][2] = v[2];
        }
    }

    REP(i, maxd) {
        dp[n][i][0] += dp[n][i][2];
        dp[n][i][0] %= MOD;
        dp[n][i][2] = 0;
    }
    
    dp[n].push_front({1, 1, 0});
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    int N; cin >> N; N += 1;
    REP2(i, 1, N) {
        int p; cin >> p;
        G[p].push_back(i);
    }

    p2[0] = 1;
    REP(i, N+1) p2[i+1] = p2[i] * 2 % MOD;

    dfs(0, 0);
    ll ans = 0;

    REP(i, (int)dp[0].size()) {
        ans += dp[0][i][1] * p2[N - depth[i]] % MOD;
        ans %= MOD;
    }

    cout << ans << endl;
}
