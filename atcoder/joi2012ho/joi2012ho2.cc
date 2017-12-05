#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int A[5050];
int B[5050];
vector<int> C[10101];

int main() {
    ios::sync_with_stdio(false); cin.tie(0);

    int N, M;
    cin >> N >> M;
    REP(i, N) cin >> A[i];
    REP(i, M) cin >> B[i];
    REP(i, N) C[A[i]].push_back(i);

    int ans = 0;

    REP(i, M) {
        int last = -1;
        int tmp = 0;
        REP2(j, i, M) {
            auto itr = lower_bound(C[B[j]].begin(), C[B[j]].end(), last+1);
            if (itr == C[B[j]].end()) break;
            last = *itr;
            tmp += 1;
        }
        ans = max(ans, tmp);
    }

    cout << ans << endl;
} #include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int A[5050];
int B[5050];
vector<int> C[10101];

int main() {
    ios::sync_with_stdio(false); cin.tie(0);

    int N, M;
    cin >> N >> M;
    REP(i, N) cin >> A[i];
    REP(i, M) cin >> B[i];
    REP(i, N) C[A[i]].push_back(i);

    int ans = 0;

    REP(i, M) {
        int last = -1;
        int tmp = 0;
        REP2(j, i, M) {
            auto itr = lower_bound(C[B[j]].begin(), C[B[j]].end(), last+1);
            if (itr == C[B[j]].end()) break;
            last = *itr;
            tmp += 1;
        }
        ans = max(ans, tmp);
    }

    cout << ans << endl;
}
