#include <iostream>
#include <stack>
#include <map>
using namespace std;

int H, W;
pair<int, int> start, goal;
char board[500][500];
bool visited[500][500];
int dr[4] = {0, 0, 1, -1};
int dc[4] = {1, -1, 0, 0};

bool astar() {}

bool dfs() {
  stack<pair<int, int> > st;
  st.push(start);
  pair<int, int> pos;
  int i, r, c, nr, nc;

  while (!st.empty()) {
    pos = st.top();
    st.pop();
    r = pos.first;
    c = pos.second;
    if (board[r][c] == 'g')
      return true;
    if (visited[r][c])
      continue;
    visited[r][c] = true;

    for (i = 0; i < 4; i++) {
      nr = r + dr[i];
      nc = c + dc[i];
      if (visited[nr][nc] || nr < 0 || nc < 0 || nr >= H || nc >= W || board[nr][nc] == '#')
	continue;
      st.push(pair<int, int>(nr, nc));
    }
  }
  return false;
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  
  cin >> H >> W;

  for (int i = 0; i < H; i++) {
    for (int j = 0; j < W; j++) {
      cin >> board[i][j];
      if (board[i][j] == 's') {
	start.first = i;
	start.second = j;
      } else if (board[i][j] == 'g') {
	goal.first = i;
	goal.second = j;
      }
    }
  }

  if (dfs())
    cout << "Yes" << endl;
  else
    cout << "No" << endl;
}
