#include <bits/stdc++.h>

using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)


int main() {
    int N, M, a, b;
    cin >> N >> M;

    
    int atari = 0;
    vector<int> hazure;

    REP(i, M) {
	cin >> a >> b;
	if (a >= N) atari += 1;
	else hazure.push_back(N-a);
    }


    sort(hazure.begin(), hazure.end());
    int ans = 0;
    
    for (int i = 0; atari < M - 1; i++) {
	ans += hazure[i];
	atari += 1;
    }


    cout << ans << endl;
}
