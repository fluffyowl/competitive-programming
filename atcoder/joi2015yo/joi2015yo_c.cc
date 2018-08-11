#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;

string A[111];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    int H, W;
    cin >> H >> W;
    REP(i, H) cin >> A[i];

    REP(i, H) {
        int ans = -1;
        REP(j, W) {
            if (A[i][j] == 'c') ans = 0;
            else if (ans >= 0) ans += 1;
            cout << ans;
            if (j != W-1) cout << " ";
        }
        cout << endl;
    }
}
