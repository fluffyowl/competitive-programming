#include <iostream>
#include <vector>
#include <algorithm> // sort
#include <map> // pair
using namespace std;
typedef vector<vector<int> > matrix;
typedef pair<int, pair<int, int> > pp;

int main(){
  int mod = 1000000007;
  int i, j, H, W;
  cin >> H >> W;
  matrix grid(H+2, vector<int>(W+2, 0));
  vector<pp> q;
  for (i = 1; i < H+1; i++) {
    for (j = 1; j < W+1; j++){
      cin >> grid[i][j];
      q.push_back(make_pair(grid[i][j], make_pair(i, j)));
    }
  }
  sort(q.begin(), q.end());

  matrix ans(H+2, vector<int>(W+2, 1));

  int n, y, x, a;
  for (i = 0; i < (int)q.size(); i++) {
    n = q[i].first;
    y = q[i].second.first;
    x = q[i].second.second;
    a = ans[y][x];
    if (n < grid[y+1][x])
      ans[y+1][x] = (ans[y+1][x] + a) % mod;
    if (n < grid[y-1][x])
      ans[y-1][x] = (ans[y-1][x] + a) % mod;
    if (n < grid[y][x+1])
      ans[y][x+1] = (ans[y][x+1] + a) % mod;
    if (n < grid[y][x-1])
      ans[y][x-1] = (ans[y][x-1] + a) % mod;
  }

  a = 0;
  for (i = 1; i < H+1; i++) {
    for(j = 1; j < W+1; j++) {
      a = (a + ans[i][j]) % mod;
    }   
  }
  cout << a << endl;
}
