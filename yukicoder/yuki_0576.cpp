#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;
const ll MOD = 1000000007;

int N, K;
double A[501010];
double B[1010100];

bool check(double p) {
    B[0] = 0;
    REP(i, 2*N) B[i+1] = B[i] + A[i%N] - p;
    deque<double> q;
    
    REP2(i, K-1, N) {
        while (!q.empty() && q.back() < B[i+1])
            q.pop_back();
        q.push_back(B[i+1]);
    }
    
    if (q.front() >= B[0])
        return true;
    
    REP2(i, 1, N) {
        if (q.front() == B[i+K-1])
            q.pop_front();
        while (!q.empty() && q.back() < B[i+N])
            q.pop_back();
        q.push_back(B[i+N]);
        if (q.front() >= B[i])
            return true;
    }

    return false;
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    cin >> N >> K;
    string S; cin >> S;
    REP(i, N) A[i] = S[i] - '0';

    double hi = 1.0;
    double lo = 0.0;
    REP(_, 80) {
        double mid = (hi + lo) / 2;
        (check(mid) ? lo : hi) = mid;
    }

    cout.precision(20);
    cout << fixed  << hi << endl;    
}

