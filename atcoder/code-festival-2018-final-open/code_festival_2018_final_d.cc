#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

typedef bitset<52> bs1;
typedef bitset<52*52> bs2;
typedef bitset<52*52*52> bs3;
typedef bitset<30000> bs;

int N;
string A[30303];
bs dp3[52*52*52];

int mp(char c) {
    if ('A' <= c && c <= 'Z') return c - 'A';
    return c - 'a' + 26;
}

int main() {
    cin >> N;
    REP(i, N) cin >> A[i];

    REP(j, N) {
        bs1 dp1;
        bs2 dp2;
        for (auto c: A[j]) {
            REP (i, 52*52) if (dp2[i]) dp3[i*52+mp(c)][j] = true;
            REP (i, 52) if (dp1[i]) dp2[i*52+mp(c)] = true;
            dp1[mp(c)] = true;
        }
    }

    int mv = -1;
    int mi = -1;

    REP(i, 52*52*52) {
        int v = (int)dp3[i].count();
        if (v > mv) {
            mv = v;
            mi = i;
        }
    }

    string ans = "";
    int y = mi;
    REP(_, 3) {
        if (y % 52 < 26) ans = (char)('A' + (y % 52)) + ans;
        else ans = (char)('a' + (y % 52 - 26)) + ans;
        y /= 52;
    }

    cout << ans << endl;
}
