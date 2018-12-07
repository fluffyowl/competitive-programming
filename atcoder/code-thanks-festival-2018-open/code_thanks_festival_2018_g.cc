#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

int N, K;
int A[5050];
int B[5050];
vector<pair<int,int>> AB;
bool used[5050];
int dp[5050][5050][2][2];

vector<int> group(int n) {
    vector<int> ret = {n};
    while (AB[ret.back()].second != AB[n].first) {
        ret.push_back(AB[ret.back()].second);
    }
    for (auto x: ret) {
        used[x] = true;
    }
    return ret;
}

void solve() {
    cin >> N >> K;
    REP(i, N) cin >> A[i];
    REP(i, N) cin >> B[i];

    REP(i, N) AB.push_back(make_pair(A[i]-1, B[i]-1));
    sort(AB.begin(), AB.end());

    vector<vector<int>> G;
    REP(i, N) if (!used[i]) G.push_back(group(i));

    int M = G.size();
    REP(i, N+1) REP(j, N+2) REP(x, 2) REP(y, 2) dp[i][j][x][y] = - (1 << 29);
    dp[0][0][0][0] = 0;
    int c = 0;

    REP(i, M) {
        int n = G[i].size();
        REP(j, n) {
            int a = AB[G[i][j]].first + 1;
            int b = AB[G[i][j]].second + 1;
            REP(k, N+1) {
                REP(x, 2) {
                    if (j == 0) {
                        int v = max({dp[c][k][0][0], dp[c][k][0][1], dp[c][k][1][0], dp[c][k][1][1]});
                        if (x == 0) dp[c+1][k+1][0][0] = max(dp[c+1][k+1][0][0], v + a);
                        if (x == 1) dp[c+1][k+1][1][1] = max(dp[c+1][k+1][1][1], v + b);
                    } else if (j == n - 1) {
                        if (x == 0) {
                            dp[c+1][k][x][0] = max(dp[c+1][k][x][0], dp[c][k][x][1] + a);
                            dp[c+1][k][x][1] = max({dp[c+1][k][x][1], dp[c][k][x][0] + b, dp[c][k][x][1] + b});
                            dp[c+1][k+1][x][0] = max(dp[c+1][k+1][x][0], dp[c][k][x][0] + a);
                        } else {
                            dp[c+1][k][x][0] = max(dp[c+1][k][x][0], dp[c][k][x][1] + a);
                            dp[c+1][k+1][x][0] = max(dp[c+1][k+1][x][0], dp[c][k][x][0] + a);
                            dp[c+1][k+1][x][1] = max({dp[c+1][k+1][x][1], dp[c][k][x][0] + b, dp[c][k][x][1] + b});
                        }
                    } else {
                        dp[c+1][k][x][0] = max(dp[c+1][k][x][0], dp[c][k][x][1] + a);
                        dp[c+1][k+1][x][0] = max(dp[c+1][k+1][x][0], dp[c][k][x][0] + a);
                        dp[c+1][k+1][x][1] = max({dp[c+1][k+1][x][1], dp[c][k][x][0] + b, dp[c][k][x][1] + b});
                    }
                }
            }
            c += 1;
        }
    }


    int ans = 0;
    REP2 (j, K, N+1) ans = max({ans, dp[N][j][0][0], dp[N][j][0][1], dp[N][j][1][0], dp[N][j][1][1]});
    cout << ans << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}
