#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
  int N, M, T, ans, i, t;
  vector<int> takuhai;
  cin >> N >> M >> T;
  for (i = 0; i < N; i++) {
    cin >> t;
    takuhai.push_back(t);
  }

  ans = takuhai[0] - M + max(T - takuhai[takuhai.size()-1] - M, 0);
  for (i = 0; i < takuhai.size()-1; i++) {
    ans += max(takuhai[i+1] - takuhai[i] - 2*M, 0);
  }

  cout << ans << endl;
  return 0;
}
