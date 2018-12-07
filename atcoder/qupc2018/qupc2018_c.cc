#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const ll MOD = 1000000007;
const int INF = 1 << 29;

int dr[4] = {0, 0, -1, 1};
int dc[4] = {-1, 1, 0, 0};
int H, W, X, sr, sc, gr, gc;
string A[1010];
int B[1010][1010];
int D[1010][1010];

void solve() {
    cin >> H >> W >> X;
    REP(i, H) cin >> A[i];
    REP(i, H) REP(j, W) B[i][j] = INF;
    REP(i, H) REP(j, W) D[i][j] = INF;

    deque<tuple<int,int,int>> q;
    REP(i, H) REP(j, W) {
        if (A[i][j] == 'S') {
            sr = i;
            sc = j;
        } else if (A[i][j] == 'G') {
            gr = i;
            gc = j;
        } else if (A[i][j] == '@') {
            q.push_back(make_tuple(i, j, 0));
        }
    }

    while (!q.empty()) {
        auto t = q.front();
        int r = get<0>(t);
        int c = get<1>(t);
        int d = get<2>(t);
        q.pop_front();
        if (B[r][c] <= d) continue;
        B[r][c] = d;
        REP(i, 4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            int nd = d + 1;
            if (B[nr][nc] <= nd || A[nr][nc] == '#') continue;
            q.push_back(make_tuple(nr, nc, nd));
        }
    }

    q.push_back(make_tuple(sr, sc, 0));
    while (!q.empty()) {
        auto t = q.front();
        int r = get<0>(t);
        int c = get<1>(t);
        int d = get<2>(t);
        q.pop_front();
        if (r == gr && c == gc) {
            cout << d << endl;
            return;
        }
        if (d >= D[r][c]) continue;
        D[r][c] = d;
        REP(i, 4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            int nd = d + 1;
            if (D[nr][nc] <= nd || A[nr][nc] == '#' || B[nr][nc] <= X) continue;
            q.push_back(make_tuple(nr, nc, nd));
        }
    }

    cout << -1 << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}
