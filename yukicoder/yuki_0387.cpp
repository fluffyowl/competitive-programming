#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

int N;
int A[101010];
int B[101010];
bitset<202020> bs;
bitset<202020> ans;
bitset<202020> tmp;
vector<int> rev[101010];

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);
    
    cin >> N;
    REP(i, N) cin >> A[i];
    REP(i, N) cin >> B[i];

    REP(i, N) rev[A[i]].push_back(i);
    REP(i, N) bs[i] = B[i] == 1;

    REP(c, 101010) {
        tmp = 0;
        for (auto i: rev[c]) 
            tmp |= (bs << i);
        ans ^= tmp;
    }

    REP(i, 2*N-1) cout << (ans[i] ? "ODD" : "EVEN") << "\n";
}

