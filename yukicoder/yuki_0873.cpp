#include <bits/stdc++.h>
#include <vector>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int N;
int dp[303030];
vector<bool> ans[303030];
vector<bool> tmp;

void solve() {
    cin >> N;
    REP(i, N+1) dp[i] = 1 << 29;

    dp[0] = 0;

    REP(i, N) for (ll j = 1; i + j * j <= N; ++j) {
        if (dp[i] + j < dp[i + j * j]) {
            dp[i + j * j] = dp[i] + j;
            ans[i + j * j] = ans[i];
            int last = i == 0 ? 0 : ans[i].back();
            REP(_, j) ans[i + j * j].push_back(last), last ^= 1;
        } else if (dp[i] + j == dp[i + j * j]) {
            tmp = ans[i];
            int last = i == 0 ? 0 : ans[i].back();
            REP(_, j) tmp.push_back(last), last ^= 1;
            ans[i + j * j] = min(ans[i + j * j], tmp);
        }
    }

    REP(i, ans[N].size()) cout << ans[N][i] ? 1 : 0;
    cout << "\n";
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    solve();
}

