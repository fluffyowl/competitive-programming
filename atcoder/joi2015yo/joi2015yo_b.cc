#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;

ll A[111];
ll P[111];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    ll N, M;
    cin >> N >> M;
    REP(i, M) cin >> A[i];

    REP(i, M) {
        ll b;
        ll tmp = 0;
        REP(j, N) {
            cin >> b;
            if (b == A[i]) {
                P[j] += 1;
            } else {
                tmp += 1;
            }
        }
        P[A[i]-1] += tmp;
    }

    REP(i, N) cout << P[i] << "\n";
}
