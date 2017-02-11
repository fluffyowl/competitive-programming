#include <bits/stdc++.h>
using namespace std;

const long double INF = 1e12;
const long double EPS = 1e-12;

int N, M;
vector<int> cnt, cost;
vector<vector<int>> idols;
vector<vector<long double>> prob;
long double mem[1030];


long double dp(int b) {
    if (b == (1<<N)-1) return 0;
    if (abs(mem[b] - INF) > EPS) return mem[b];

    long double ret = INF;
    for (int i = 0; i < M; i++) {
	long double dup = 0;
	long double e = cost[i];
	for (int j = 0; j < cnt[i]; j++) {
	    if (b & (1 << idols[i][j])) {
		dup += prob[i][j];
	    }
	    else {
		long double x = dp(b | (1 << idols[i][j]));
		e += prob[i][j] * x;
	    }
	}

	if (dup + EPS >= 1.0L)
	    continue;
	else
	    ret = min(ret, e/(1-dup));
    }

    return mem[b] = ret;
}

int main() {
    cin >> N >> M;

    cnt.resize(M);
    cost.resize(M);
    idols.resize(M);
    prob.resize(M);

    for (int i = 0; i < M; i++) {
	cin >> cnt[i] >> cost[i];
	for (int j = 0; j < cnt[i]; j++) {
	    int idol, p;
	    cin >> idol >> p;
	    idols[i].push_back(idol-1);
	    prob[i].push_back(0.01L*p);
	}
    }

    for (int i = 0; i < 1024; i++) {
	mem[i] = INF;
    }

    cout << fixed << setprecision(10) << dp(0) << endl;
}
