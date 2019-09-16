#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

ll N, P;
bool isP[1000100];

void solve() {
    cin >> N >> P;

    if (P == 1) {
        cout << 1 << "\n";
        return;
    }

    REP(i, 1000100) isP[i] = true;

    for (int i = 2; i * i <= N; ++i) {
        if (!isP[i]) continue;
        for (int j = i + i; j <= N; j += i) {
            isP[j] = false;
        }
    }

    int cnt = N - 1;
    REP2(i, N/2+1, N+1) cnt -= isP[i];

    if (!isP[P] || P <= N/2) {
        cout << cnt << "\n";
    } else {
        cout << 1 << "\n";
    }
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    solve();
}

