#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const int MAX = 500001;
string S;
int N;

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    cin >> S;
    N = (int)S.size();

    if (S[0] == '0') {
        cout << 0 << endl;
        return 0;
    } else if (N == 1) {
        cout << 1 << endl;
        return 0;
    }

    int ans = 1;

    REP2(i, 1, N) if (S[i] == '1') {
        int tmp = 2;
        for (int j = i + i; j < N; j += i) {
            if (S[j] == '0') break;
            tmp += 1;
        }
        ans = max(ans, tmp);
    }

    if (ans < 3 && N > 2) {
        REP2(i, 1, N) if (S[i] == '1' && i*2 < N && S[i*2] == '1') ans = 3;
    }


    if (ans < 4 && N > 3) {
        mt19937 mt(50);
        vector<int> hoge;
        REP2(i, 1, N) if (S[i] == '1') hoge.push_back(i);
        uniform_int_distribution<int> rnd(0, (int)hoge.size() - 1);
        REP(_, 30000000) {
            int i = rnd(mt);
            int j = rnd(mt);
            if (i != j && hoge[i] + hoge[j] < N && S[hoge[i] + hoge[j]] == '1') {
                ans = 4;
                break;
            }
        }
    }

    cout << ans << endl;
}
