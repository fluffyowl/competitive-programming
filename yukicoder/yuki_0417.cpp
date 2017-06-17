#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int N, M;
int U[200];
vector<pair<int, int> > edges[200];
int dp[200][2001];
int tmp[2][2001];

void dfs(int n, int prev) {
    for (auto m: edges[n])
        if (m.first != prev)
            dfs(m.first, n);

    memset(tmp, 0, sizeof(tmp));
    int cur = 0;
    int tar = 1;

    for (auto m: edges[n]) {
        if (m.first == prev)
                continue;
        REP(i, M+1) {
            int ii = i + m.second * 2;
            if (ii > M)
                break;
            REP(j, M+1) {
                if (ii + j > M)
                    break;
                tmp[tar][ii+j] = max(tmp[tar][ii+j], dp[m.first][i] + tmp[cur][j]);
            }
        }

        REP(i, M+1) tmp[cur][i] = tmp[tar][i];
        cur ^= 1;
        tar ^= 1;
    }

    REP(i, M+1) dp[n][i] = tmp[cur][i] + U[n];
}


int main() {
    cin >> N >> M;
    REP(i, N) cin >> U[i];
    REP(i, N-1) {
        int a, b, c;
        cin >> a >> b >> c;
        edges[a].push_back(make_pair(b, c));
        edges[b].push_back(make_pair(a, c));
    }

    dfs(0, -1);
    int ans = 0;
    REP(i, M+1) ans = max(ans, dp[0][i]);
    cout << ans << endl;
}

