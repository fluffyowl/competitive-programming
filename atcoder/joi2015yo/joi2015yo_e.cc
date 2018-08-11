#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;
const ll INF = 1LL << 59;

const int dr[8] = {-1, -1, -1, 0, 0, 1, 1, 1};
const int dc[8] = {-1, 0, 1, -1, 1, -1, 0, 1};
int A[1010][1010];
bool used[1010][1010];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    int H, W;
    cin >> H >> W;
    REP(i, H) {
        string s;
        cin >> s;
        REP(j, W) A[i][j] = (s[j] >= '0' && s[j] <= '9') ? s[j] - '0' : 0;
    }

    stack<pair<int, int>> st1;
    stack<pair<int, int>> st2;
    int ans = 0;

    REP2(i, 1, H-1) REP2(j, 1, W-1) if (A[i][j] > 0) {
        int cnt = 0;
        REP(k, 8) {
            int nr = i + dr[k];
            int nc = j + dc[k];
            if (A[nr][nc] == 0) ++cnt;
        }
        if (cnt >= A[i][j]) st1.push({i, j}), used[i][j] = true;;
    }

    while (!st1.empty()) {
        ++ans;
        while (!st1.empty()) {
            int r = st1.top().first;
            int c = st1.top().second;
            st1.pop();
            A[r][c] = 0;
            st2.push({r, c});
        }
        while (!st2.empty()) {
            int r = st2.top().first;
            int c = st2.top().second;
            st2.pop();
            REP(k, 8) {
                int nr = r + dr[k];
                int nc = c + dc[k];
                if (used[nr][nc]) continue;
                if (nr > 0 && nr < H-1 && nc > 0 && nc < W-1 && A[nr][nc] > 0) {
                    int cnt = 0;
                    REP(kk, 8) {
                        int nnr = nr + dr[kk];
                        int nnc = nc + dc[kk];
                        if (A[nnr][nnc] == 0) ++cnt;
                    }
                    if (cnt >= A[nr][nc]) st1.push({nr, nc}), used[nr][nc] = true;
                }
            }
        }
    }

    cout << ans << endl;
}
