#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const int MAX = 3652425;
const ll INF = 1LL<<60;

int N, Q;
ll W[101010];
ll T[101010];
ll X[101010];
ll P[MAX+1];
ll dw0[MAX+1];
ll dw1[MAX+1];
ll dv1[MAX+1];
ll dw2[MAX+1];
ll dv2[MAX+1];
ll dvv2[MAX+1];
ll dvvv2[MAX+1];

int main() {
    ios::sync_with_stdio(false), cin.tie(0);

    cin >> N >> Q;
    REP(i, N) cin >> W[i] >> T[i] >> X[i];

    P[0] = 0;
    int p = 0;
    ll w0 = 0;
    ll w1 = 0;
    ll v1 = 0;
    ll w2 = 0;
    ll v2 = 0;
    ll vv2 = 0;
    ll vvv2 = 0;

    REP(i, MAX+1) {
        if (i > 0) {
            w1 += v1;
            vv2 += vvv2;
            if (vv2 > 0) v2 = vv2*2-vvv2;
            else v2 = 0;
            w2 += v2;
            P[i] = P[i-1] + 1 + w0 + w1 + w2;
            P[i] = min(P[i], INF);
            w0 -= dw0[i];
            w1 -= dw1[i];
            v1 -= dv1[i];
            w2 -= dw2[i];
            v2 -= dv2[i];
            vv2 -= dvv2[i];
            vvv2 -= dvvv2[i];
        }

        while (p < N && P[i] >= W[p]) {
            cout << i << "\n";
            if (T[p] == 0) {
                w0 += 1;
                if (i + X[p] <= MAX) {
                    dw0[i + X[p]] += 1;
                }
            } else if (T[p] == 1) {
                v1 += 1;
                if (i + X[p] <= MAX) {
                    dw1[i + X[p]] += X[p];
                    dv1[i + X[p]] += 1;
                }
            } else {
                vvv2 += 1;
                if (i + X[p] <= MAX) {
                    dw2[i + X[p]] += X[p] * X[p];
                    dvv2[i + X[p]] += X[p];
                    dvvv2[i + X[p]] += 1;
                }
            }
            p += 1;
        }
    }

    for (; p < N; ++p) {
        cout << "Many years later" << "\n";
    }

    while (Q--) {
        int i; cin >> i;
        cout << P[i] << "\n";
    }

} #include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const int MAX = 3652425;
const ll INF = 1LL<<60;

int N, Q;
ll W[101010];
ll T[101010];
ll X[101010];
ll P[MAX+1];
ll dw0[MAX+1];
ll dw1[MAX+1];
ll dv1[MAX+1];
ll dw2[MAX+1];
ll dv2[MAX+1];
ll dvv2[MAX+1];
ll dvvv2[MAX+1];

int main() {
    ios::sync_with_stdio(false), cin.tie(0);

    cin >> N >> Q;
    REP(i, N) cin >> W[i] >> T[i] >> X[i];

    P[0] = 0;
    int p = 0;
    ll w0 = 0;
    ll w1 = 0;
    ll v1 = 0;
    ll w2 = 0;
    ll v2 = 0;
    ll vv2 = 0;
    ll vvv2 = 0;

    REP(i, MAX+1) {
        if (i > 0) {
            w1 += v1;
            vv2 += vvv2;
            if (vv2 > 0) v2 = vv2*2-vvv2;
            else v2 = 0;
            w2 += v2;
            P[i] = P[i-1] + 1 + w0 + w1 + w2;
            P[i] = min(P[i], INF);
            w0 -= dw0[i];
            w1 -= dw1[i];
            v1 -= dv1[i];
            w2 -= dw2[i];
            v2 -= dv2[i];
            vv2 -= dvv2[i];
            vvv2 -= dvvv2[i];
        }

        while (p < N && P[i] >= W[p]) {
            cout << i << "\n";
            if (T[p] == 0) {
                w0 += 1;
                if (i + X[p] <= MAX) {
                    dw0[i + X[p]] += 1;
                }
            } else if (T[p] == 1) {
                v1 += 1;
                if (i + X[p] <= MAX) {
                    dw1[i + X[p]] += X[p];
                    dv1[i + X[p]] += 1;
                }
            } else {
                vvv2 += 1;
                if (i + X[p] <= MAX) {
                    dw2[i + X[p]] += X[p] * X[p];
                    dvv2[i + X[p]] += X[p];
                    dvvv2[i + X[p]] += 1;
                }
            }
            p += 1;
        }
    }

    for (; p < N; ++p) {
        cout << "Many years later" << "\n";
    }

    while (Q--) {
        int i; cin >> i;
        cout << P[i] << "\n";
    }

}
