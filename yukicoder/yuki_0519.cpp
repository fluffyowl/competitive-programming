#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

int F[25][25];
int dp[1 << 24];

int NumberOfSetBits(int i)
{
     i = i - ((i >> 1) & 0x55555555);
     i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
     return (((i + (i >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24;
}

int main(){
    int N; cin >> N;
    REP(i, N) REP(j, N) cin >> F[i][j];

    memset(dp, 0, sizeof(dp));

    for (int mask = 0; mask < (1 << N); mask++) {
        if (NumberOfSetBits(mask) % 2 == 1) continue;
        int i = N + 1;
        REP(ii, N) if (!(mask & (1 << ii))) {i = ii; break;}
        REP2(j, i+1, N)
            if (!(mask & (1 << j))) 
                dp[mask | (1 << i) | (1 << j)] = max(dp[mask | (1 << i) | (1 << j)],
                                                     dp[mask] + F[i][j]);
    }

    cout << dp[(1 << N) - 1] << endl;

    return 0;
}

