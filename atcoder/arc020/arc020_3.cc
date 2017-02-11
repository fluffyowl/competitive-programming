#include <bits/stdc++.h>
using namespace std;

#define ll long long

ll powmod(ll a, ll x, ll m) {
    a %= m;
    ll ret = 1;
    while (x > 0) {
        if (x % 2 == 1) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

ll keta(ll n) {
    ll ret = 1;
    for (int i = 0; i < to_string(n).length(); i++) ret *= 10;
    return ret;
}

int main() {
    ll N, B;
    cin >> N;
    vector<int> A(N), L(N);
    for (int i = 0; i < N; i++) cin >> A[i] >> L[i];
    cin >> B;

    ll ans = 0;
    for (int i = 0; i < N; i++) {
        ll ratio = keta(A[i]) % B;

        ll dp[35];
        dp[0] = A[i];

        ll tmp = 0;
        ll k = 0;

        for (int j = 1; j < 32; j++)
            dp[j] = (dp[j-1] * powmod(ratio, (1 << (j-1)), B) % B + dp[j-1]) % B;
        for (int j = 0; j < 32; j++) {
            if (L[i] & (1 << j)) {
                tmp = (tmp + dp[j] * powmod(ratio, k, B) % B) % B;
                k += (1 << j);
                //cout << k << endl;
            }
        }

        ll d = (ll)to_string(A[i]).length() * L[i];
        ans = (ans * powmod(10, d, B) % B + tmp) % B;
    }

    cout << (ans+B)%B << endl;
}
