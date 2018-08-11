#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    ll A, B, C, D, P;
    cin >> A >> B >> C >> D >> P;
    ll X = A * P;
    ll Y = B + max(0LL, P - C) * D;
    cout << min(X, Y) << endl;
}
