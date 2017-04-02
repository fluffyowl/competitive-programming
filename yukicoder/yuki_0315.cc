#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define ll long long

const int MOD = 1000000007;
int dp[2][2][3][2][800];

int solve(string N, int P, bool less) {
    int M = N.size();
    memset(dp[0], 0, sizeof(dp[0]));
    dp[0][0][0][0][0] = 1;

    REP(a, M) {
        int cur = a % 2;
        int tar = 1 - cur;
        int dig = N[a] - '0';
        memset(dp[tar], 0, sizeof(dp[tar]));
        REP(b, 2) REP (c, 3) REP(d, 2) {
            int digit = b ? 10 : dig+1;
            if (M - a < 6) {
                REP (e, P) REP (f, digit) {
                    dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][(10*e+f)%P] +=
                        dp[cur][b][c][d][e];
                    dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][(10*e+f)%P] %= MOD;
                }
            }
            else {
                REP (f, digit) {
                    dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][0] +=
                        dp[cur][b][c][d][0];
                    dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][0] %= MOD;
                }
            }
        }
    }

    int ret = 0;
    REP(b, 2) {
        if (less && (b == 0)) continue;
        REP(c, 3) REP(d, 2) REP(e, P) {
            if ((c == 0 || d == 1) && e != 0) {
                ret += dp[M%2][b][c][d][e];
                ret %= MOD;
            }
        }
    }

    return ret;
}

int main() {
    string A, B;
    int P;
    cin >> A >> B >> P;

    int a = solve(A, P, true);
    int b = solve(B, P, false);
    int ans = (b - a) % MOD;
    ans = (ans + MOD) % MOD;

    cout << ans << endl;
}

