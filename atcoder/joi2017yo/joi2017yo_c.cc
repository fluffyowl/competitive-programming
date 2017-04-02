#include <bits/stdc++.h>

using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)

int N, M, D;
char B[110][110];


int main() {
    cin >> N >> M >> D;
    REP(i, N) REP(j, M) cin >> B[i][j];


    int ans = 0;
    
    REP(i, N) REP(j, M-D+1) {
	bool ok = true;
	REP(k, D) if (B[i][j+k] != '.') ok = false;
	if (ok) ans += 1;
    }
    
    REP(j, M) REP(i, N-D+1) {
	bool ok = true;
	REP(k, D) if (B[i+k][j] != '.') ok = false;
	if (ok) ans += 1;
    }


    cout << ans << endl;
}
