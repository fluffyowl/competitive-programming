#include <vector>
#include <iostream>
using namespace std;

class UnionFind {
public:
  vector<int> table;
  UnionFind(int n) {
    table = vector<int> (n, -1);
  }
  
  ~UnionFind(){};
  
  void unite(int x, int y) {
    x = find(x);
    y = find(y);
    if (x == y) return;
    if (table[x] >= table[y]) {
      table[y] += table[x];
      table[x] = y;
    } else {
      table[x] += table[y];
      table[y] = x;
    }
  }

  int find(int x) {
    if (table[x] < 0) return x;
    return table[x] = find(table[x]);  // 根を張り替えながら再帰的に根ノードを探す
  }
};

int N;
long long int dists[1001][1001];
long long int f(long long int x0, long long int y0, long long int x1, long long int y1) {
  return (x0-x1)*(x0-x1) + (y0-y1)*(y0-y1);
}
bool ok(long long int m) {
  UnionFind uf = UnionFind(N);
  for (int i = 0; i < N; i++)
    for (int j = i+1; j < N; j++)
      if (dists[i][j] <= m) {
	uf.unite(i, j);
      }
  return uf.find(0) == uf.find(N-1);
}
long long int sqrtint(long long int n) {
  long long int i;
  for (i = 0; n > 0; i++)
    n -= i * 2 + 1;
  return i-1;
}
  
int main() {
  long long int x[1000];
  long long int y[1000];
  cin >> N;
  for (int i = 0; i < N; i++) {
    cin >> x[i] >> y[i];
  }

  long long int high = 1000000000000000000*3;
  long long int low = 0;
  long long int  middle;

  for (int i = 0; i < N; i++) 
    for (int j = i+1; j < N; j++)
      dists[i][j] = f(x[i], y[i], x[j], y[j]);

  while (high-low > 1) {
    middle = (high+low)/2;
    if (ok(middle))
      high = middle;
    else
      low = middle;
  }

  if (!ok(high))
    high = low;
  long long int sqrt = sqrtint(high);
  if (sqrt*sqrt < high)
    sqrt++;

  long long int ans = sqrt/10*10;
  if (sqrt%10 > 0)
    ans += 10;
  cout << ans << endl;
  return 0;
}

