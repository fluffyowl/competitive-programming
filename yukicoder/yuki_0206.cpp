#include <bits/stdc++.h>
using namespace std;

int main() {
    int L, M, N, a, b, Q;
    bitset<100010> A, B;

    cin >> L >> M >> N;
    for (int i = 0; i < L; i++) {cin >> a; A[a] = true;}
    for (int i = 0; i < M; i++) {cin >> b; B[b] = true;}
    cin >> Q;

    while (Q--) {
      cout << (A&B).count() << endl;
      B <<= 1;
    }
  
    return 0;
}

