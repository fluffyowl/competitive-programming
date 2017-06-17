#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MOD = 1000000007;
ll N;
ll A[101010];
ll pow2[101010];
ll acm[101010];

ll powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void solve() {
    cin >> N;
    REP(i, N) cin >> A[i];

    acm[0] = A[0];
    REP(i, N-1) {
        acm[i+1] = (acm[i] * A[i+1]) % MOD;
    }

    ll ans = 0;
    ll tmp = 0;
    REP(i, N) {
        ll tmptmp = acm[i];
        tmptmp = tmptmp * pow2[max(0LL, N-i-2)] % MOD;
        tmp += tmptmp;
        tmp %= MOD;
    }

    REP(i, N) {
        ans = (ans + tmp) % MOD;
        ll hiku = A[i] * pow2[(max(0LL, N-i-2))+max(0LL, (ll)i-1)] % MOD;
        tmp = (tmp - hiku) % MOD;
        tmp = (tmp + MOD) % MOD;
        tmp = tmp * powmod(A[i], MOD-2, MOD) % MOD;
        if (i >= 1) tmp = tmp * 2 % MOD;
        //writeln(ans, " ", tmp);
    }

    cout << ans << endl;
}

int main() {
    pow2[0] = 1;
    REP(i, 100010)
        pow2[i+1] = pow2[i] * 2 % MOD;

    int T;
    //cin >> T;
    T = 1;
    while (T--) solve();

    return 0;
}
