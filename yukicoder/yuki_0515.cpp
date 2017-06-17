#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

const int NMAX = 101010;
const int MMAX = 3010101;
const int LOGNMAX = 25;
int N, M;
long x, d;
vector<pair<string, int> > S;
int A[NMAX], I[MMAX], J[MMAX], rev[NMAX], D[NMAX];
int dp[NMAX][LOGNMAX];


int getmin(int i, int j) {
    int m = j - i + 1;
    int k = 0;
    while (m >>= 1) k += 1;
    int h = A[dp[i][k]] <= A[dp[j-(1<<k)+1][k]] ? dp[i][k] : dp[j-(1<<k)+1][k];
    return A[h];
}    


int main() {
    cin >> N;
    REP(i, N) {
        string s;
        cin >> s;
        S.push_back(make_pair(s, i));
    }
    cin >> M >> x >> d;

    REP(k, M) {
        I[k] = (int)((x / (N - 1)) + 1);
        J[k] = (int)((x % (N - 1)) + 1);
        if (I[k] > J[k]) swap(I[k], J[k]);
        else J[k] += 1;
        x = (x + d) % ((long long)N * ((long long)N - 1));
    }

    sort(S.begin(), S.end());
    REP(i, N) rev[S[i].second] = i;

    memset(A, 0, sizeof(A));
    REP(i, N-1) REP(j, min(S[i].first.length(), S[i+1].first.length())) {
        if (S[i].first[j] == S[i+1].first[j]) A[i]++;
        else break;
    }

    REP(i, N-1) dp[i][0] = i;
    for (int j = 1; 1 << j <= N-1; j++)
        for (int i = 0; i + (1 << j) - 1 < N-1; i++)
            if (A[dp[i][j - 1]] < A[dp[i + (1 << (j - 1))][j - 1]])
                dp[i][j] = dp[i][j - 1];
            else
                dp[i][j] = dp[i + (1 << (j - 1))][j - 1];

    //long[int][int] mem;
    long long ans = 0;
    REP(k, M) {
        int i = rev[I[k] - 1];
        int j = rev[J[k] - 1];
        if (i > j) swap(i, j);
        //if (i in mem && j in mem[i]) ans += mem[i][j];
        //else ans += mem[i][j] = st.getmin(i, j-1);
        ans += getmin(i, j-1);
    }

    cout << ans << endl;
    
}

