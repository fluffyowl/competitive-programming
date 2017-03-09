#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define ll long long


int main() {
    int N, M, a, b;
    cin >> N >> M;
    
    vector<pair<int, int> > A, B;
    REP(i, N) {
	cin >> a >> b;
	A.push_back(make_pair(a, b));
    }
    REP(i, M) {
	cin >> a >> b;
	B.push_back(make_pair(b, a));
    }

    sort(A.begin(), A.end());
    sort(B.begin(), B.end());

    
    int ans = 0;
    multiset<int> mst;
    int j = 0;
    REP(i, N) {
	while (j < M && A[i].first >= B[j].first) {
	    mst.insert(B[j].second);
	    j++;
	}
	
	auto itr = mst.lower_bound(A[i].second);
	if (itr != mst.end()) {
	    ans++;
	    mst.erase(itr);
	}
    }


    cout << ans << endl;
}
