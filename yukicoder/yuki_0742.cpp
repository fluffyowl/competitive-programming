#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const ll MOD = 1000000007;
int N, K;
pair<int, int> LR[30303];
pair<int, int> RL[30303];
int same[30303];
int A[30303];

void solve() {
    int N; cin >> N;
    int x = 0, y = 0, z = 0;

    REP2(i, 1, N+1) {
        int m; cin >> m;
        if (i < m) LR[x++] = make_pair(i, m);
        else if (m < i) RL[y++] = make_pair(m, i);
        else same[z++] = i;
    }

    REP(i, z) A[same[i]] += 1;
    REP(i, N+1) A[i+1] += A[i];

    int ans = 0;

    sort(LR, LR+x);
    sort(RL, RL+y);


    REP(i, x) REP2(j, i+1, x) {
        if (LR[j].second <= LR[i].second)
            ans++;
    }

    REP(i, y) REP2(j, i+1, y) {
        if (RL[j].second <= RL[i].second)
            ans++;
    }

    REP(i, x) {
        ans += A[LR[i].second] - A[LR[i].first-1];
    }

    REP(i, y) {
        ans += A[RL[i].second] - A[RL[i].first-1];
    }

    REP(i, x) REP(j, y) {
        if (LR[i].first <= RL[j].second && LR[i].second >= RL[j].first)
            ans++;
    }

    cout << ans << endl;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}

