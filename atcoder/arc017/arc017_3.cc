#include <bits/stdc++.h>
using namespace std;

int main() {
    int N, X;
    cin >> N >> X;

    int n = N / 2;
    int m = N / 2 + N % 2;
    vector<int> A(n);
    vector<int> B(m);

    for (int i = 0; i < n; i++) cin >> A[i];
    for (int i = 0; i < m; i++) cin >> B[i];

    vector<int> C;
    vector<int> D;
    for (int i = 0; i < (1 << n); i++) {
        int w = 0;
        for (int j = 0; j < n; j++) {
            if (i & (1 << j))
                w += A[j];
        }
        C.push_back(w);
    }
    for (int i = 0; i < (1 << m); i++) {
        int w = 0;
        for (int j = 0; j < m; j++) {
            if (i & (1 << j))
                w += B[j];
        }
        D.push_back(w);
    }


    sort(D.begin(), D.end());

    long ans = 0;
    for (int i = 0; i < (1 << n); i++) {
        ans +=
            upper_bound(D.begin(), D.end(), X-C[i]) -
            lower_bound(D.begin(), D.end(), X-C[i]);
    }

    cout << ans << endl;
}
