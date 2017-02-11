#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define ll unsigned long long

ll K;
int N;
ll A[100010], D[100010];

int main() {
    cin >> K >> N;
    REP(i, N) cin >> A[i] >> D[i];

    ll hi = 1e12;
    ll lo = 0;
    while (hi - lo > 1) {
	ll mid = (hi + lo) / 2;
	ll k = 0;
	REP(i, N) if (mid >= A[i])
	    k += (mid-A[i])/D[i] + 1;
	if (k >= K) hi = mid;
	else lo = mid;
    }


    ll ans = 0;
    ll cnt = 0;
    REP(i, N) {
	if (hi < A[i]) continue;
	ll k = (hi-A[i])/D[i] + 1;
	ll s = k * (2 * A[i] + (k-1)*D[i]) / 2;
	cnt += k;
	ans += s;
    }

    ans -= (cnt-K)*hi;
    cout << ans << endl;
    return 0;
}
