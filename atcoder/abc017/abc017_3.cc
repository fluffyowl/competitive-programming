#include <iostream>
#include <vector>

using namespace std;

int main() {
  int N, M;
  cin >> N >> M;

  vector <long int> ML(M, 0);
  int L, R;
  long int S;
  long int sum = 0;
  int i, j;
  for (i = 0; i < N; i++){
    cin >> L >> R >> S;
    for (j = L-1; j < R; j++){
      ML[j] += S;
    }
    sum += S;
  }

  long int min = ML[0];
  for (i = 1; i < M; i++) {
    if (ML[i] < min)
      min = ML[i];
  }
  cout << sum - min << endl;
}
