#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const ll MOD = 1000000007;
const int INF = 1 << 29;

int N, K;
int A[20];
vector<int> teams;
ll dp[2][1 << 18];

void solve() {
    cin >> N >> K;
    REP(i, N) cin >> A[i];

    REP(i, N) {
        teams.push_back(1 << i);
    }

    REP(i, N) REP2(j, i+1, N) if (A[i] + A[j] <= K * 2) {
        teams.push_back((1 << i) + (1 << j));
    }

    REP(i, N) REP2(j, i+1, N) REP2(k, j+1, N) if (A[i] + A[j] + A[k] <= K * 3) {
        teams.push_back((1 << i) + (1 << j) + (1 << k));
    }

    dp[0][0] = 1;
    int cur = 0;
    int tar = 1;

    for (auto t: teams) {
        REP(i, 1 << N) {
            dp[tar][i] = dp[cur][i];
        }
        REP(i, 1 << N) {
            if ((i ^ t) != (i | t)) continue;
            dp[tar][i^t] += dp[cur][i];
        }
        cur ^= 1;
        tar ^= 1;
    }

    cout << dp[teams.size()%2][(1 << N) - 1] << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}
