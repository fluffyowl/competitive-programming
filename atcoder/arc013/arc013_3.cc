#include <bits/stdc++.h>
using namespace std;


int main() {
    int N;
    cin >> N;

    int grundy = 0;
    
    for (int i = 0; i < N; i++) {
	int X, Y, Z, M;
	cin >> X >> Y >> Z >> M;
	vector<int> x(M);
	vector<int> y(M);
	vector<int> z(M);
	for (int j = 0; j < M; j++) {
	    cin >> x[j] >> y[j] >> z[j];
	}
	sort(x.begin(), x.end());
	sort(y.begin(), y.end());
	sort(z.begin(), z.end());
	
	grundy ^= x.front();
	grundy ^= X - x.back() - 1;
	grundy ^= y.front();
	grundy ^= Y - y.back() - 1;
	grundy ^= z.front();
	grundy ^= Z - z.back() - 1;
	
    }

    if (grundy > 0) cout << "WIN" << endl;
    else cout << "LOSE" << endl;
    
}
