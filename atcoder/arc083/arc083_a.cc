#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;


int main() {
    ll A, B, C, D, E, F;
    cin >> A >> B >> C >> D >> E >> F;

    ll bunsi = -1, bunbo = -1;
    REP(a, 101) REP(b, 101) REP(cc, 3001) {
        if (a + b == 0)
            continue;
        ll ab = 100 * A * a + 100 * B * b;
        ll c = cc * C;
        if (ab + c > F)
            continue;
        if (ab / 100 * E < c)
            continue;
        ll dd = min(F - ab - c, ab / 100 * E - c);
        ll d = dd / D * D;
        ll cd = c + d;
        if (bunsi == -1 || bunbo * 100 * cd >= bunsi * (ab + cd))
            bunsi = 100 * cd, bunbo = ab + cd;
    }

    if (bunsi == -1)
        cout << A * 100 << " " << 0 << endl;
    else
        cout << bunbo << " " << bunsi / 100 << endl;
}
