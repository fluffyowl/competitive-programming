#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

char P[500][500];
char R[500][500];
char B[500][500];

int main() {
    int H, W;
    cin >> H >> W;
    REP(i, H) REP(j, W) cin >> P[i][j];

    REP(i, H) REP(j, W) R[i][j] = (j % 2 == 1 || P[i][j] == '#') ? '#' : '.';
    REP(i, H) REP(j, W) B[i][j] = (j % 2 == 0 || P[i][j] == '#') ? '#' : '.';
    REP(j, W) R[0][j] = B[H-1][j] = '#', R[H-1][j] = B[0][j] = '.';

    REP(i, H) {
        REP(j, W) cout << R[i][j];
        cout << endl;
    }
    
    cout << endl;
    
    REP(i, H) {
        REP(j, W) cout << B[i][j];
        cout << endl;
    }
    
    return 0;
}
