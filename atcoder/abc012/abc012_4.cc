#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

const int INF = 100000000;

typedef vector<vector<int> > Matrix;
Matrix d;

void warshall_floyd(int n) { 
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      for (int k = 0; k < n; k++)
        d[j][k] = min(d[j][k], d[j][i] + d[i][k]);
}

int main() {
  int n, m;
  cin >> n;

  d = Matrix(n, vector<int>(n, INF));
  for (int i = 0; i < n; i++) d[i][i] = 0;
  
  cin >> m;
  for (int i = 0; i < m; i++) {
    int from, to, cost;
    cin >> from >> to >> cost;
    from--;
    to--;
    d[from][to] = cost;
    d[to][from] = cost;
  }

  warshall_floyd(n);

  int maxmin = INF;
  int worst;
  
  for (int i = 0; i < n; i++) {
    worst = -1;
    for (int j = 0; j < n; j++) {
      if (d[i][j] > worst)
	worst = d[i][j];
    }
    if (worst < maxmin)
      maxmin = worst;
  }

  cout << maxmin << endl;
  return 0;
}
