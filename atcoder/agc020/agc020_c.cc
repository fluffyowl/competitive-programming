#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

int N;
int A[2020];
bitset<4040404> dp;

int main() {
    int N; cin >> N;
    REP(i, N) cin >> A[i];
    dp[0] = true;

    REP(i, N) {
        dp |= (dp << A[i]);
    }

    int ans = 0;
    REP(i, N) ans += A[i];
    ans = ans/2 + ans%2;

    while (!dp[ans]) ++ans;
    cout << ans << endl;
}
