#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int H, W, X, Y;
ll A[1010][1010];
ll B[1010][1010];

ll sum1(int i, int j, int h, int w) {
    return A[i + h][j + w] - A[i][j + w] + A[i][j] - A[i + h][j];
}

ll sum2(int i, int j, int h, int w) {
    return B[i + h][j + w] - B[i][j + w] + B[i][j] - B[i + h][j];
}

int main() {
    ios::sync_with_stdio(false); cin.tie(0);
    memset(A, 0, sizeof(A));
    memset(B, 0, sizeof(B));

    cin >> W >> H >> Y >> X;
    REP(i, H) REP(j, W) cin >> A[i+1][j+1];
    REP(i, H) REP(j, W) B[i+1][j+1] = A[i+1][j+1] == -1;

    REP(i, H+1) REP(j, W) A[i][j+1] += A[i][j];
    REP(i, H) REP(j, W+1) A[i+1][j] += A[i][j];
    REP(i, H+1) REP(j, W) B[i][j+1] += B[i][j];
    REP(i, H) REP(j, W+1) B[i+1][j] += B[i][j];

    ll ans = 1LL << 59;

    REP(i, H-X+1) REP(j, W-Y+1) if (sum2(i, j, X, Y) == 0) {
        ans = min(ans, sum1(i, j, X, Y));
    }

    cout << ans << endl;
} #include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int H, W, X, Y;
ll A[1010][1010];
ll B[1010][1010];

ll sum1(int i, int j, int h, int w) {
    return A[i + h][j + w] - A[i][j + w] + A[i][j] - A[i + h][j];
}

ll sum2(int i, int j, int h, int w) {
    return B[i + h][j + w] - B[i][j + w] + B[i][j] - B[i + h][j];
}

int main() {
    ios::sync_with_stdio(false); cin.tie(0);
    memset(A, 0, sizeof(A));
    memset(B, 0, sizeof(B));

    cin >> W >> H >> Y >> X;
    REP(i, H) REP(j, W) cin >> A[i+1][j+1];
    REP(i, H) REP(j, W) B[i+1][j+1] = A[i+1][j+1] == -1;

    REP(i, H+1) REP(j, W) A[i][j+1] += A[i][j];
    REP(i, H) REP(j, W+1) A[i+1][j] += A[i][j];
    REP(i, H+1) REP(j, W) B[i][j+1] += B[i][j];
    REP(i, H) REP(j, W+1) B[i+1][j] += B[i][j];

    ll ans = 1LL << 59;

    REP(i, H-X+1) REP(j, W-Y+1) if (sum2(i, j, X, Y) == 0) {
        ans = min(ans, sum1(i, j, X, Y));
    }

    cout << ans << endl;
}
