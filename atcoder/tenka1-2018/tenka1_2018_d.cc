#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

int N;

void solve() {
    cin >> N;
    int K = 0;
    int x;
    for (x = 1; K < N; K += x, x += 1) ;

    if (K != N) {
        cout << "No\n";
        return;
    }

    cout << "Yes\n";
    cout << x << "\n";

    vector<vector<int>> ans = vector<vector<int>>(x+1);

    int cnt = 1;
    K = 0;

    for (int i = 1; K < N; K += i, i += 1) {
        for (int j = 1; j <= i; j += 1) {
            ans[j].push_back(cnt);
            ans[i+1].push_back(cnt);
            cnt += 1;
        }
    }

    for (int i = 1; i <= x; ++i) {
        cout << ans[i].size() << " ";
        for (auto j: ans[i]) {
            cout << j << " ";
        }
        cout << "\n";
    }
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}
