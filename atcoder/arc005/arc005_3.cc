#include <stdio.h>
#include <math.h>
#include <cmath>
#include <stack>
#include <tuple>
#include <bits/stdc++.h>
using namespace std;

char meiro[505][505];
int H, W;
int SR, SC;
int dr[4] = {-1, 1, 0, 0};
int dc[4] = {0, 0, -1, 1};

bool dfs(char kaisuu) {
  stack<tuple<int,int>> st;
  st.emplace(SR,SC);
  int r, c, nr, nc;
  int i;
  char masu;
  bool visited[505][505];
  memset(visited, false, sizeof(visited));
  visited[SR][SC] = true;

  while (!st.empty()) {
    tie(r, c) = st.top();
    st.pop();

    for (i = 0; i < 4; i++) {
      nr = r + dr[i];
      nc = c + dc[i];
      
      if (nr < 0 || nr >= H || nc < 0 || nc >= W)
	continue;
      masu = meiro[nr][nc];
      if (masu == 'g')
	return true;
      if (visited[nr][nc])
	continue;
      if (masu == '#') {
	meiro[nr][nc] = kaisuu;
	continue;
      }
      if (masu == '.') {
	st.emplace(nr, nc);
	visited[nr][nc] = true;
	continue;
      }
      if (masu < kaisuu) {
	st.emplace(nr, nc);
	visited[nr][nc] = true;
      }
    }
  }
  return false;
}

int main() {
  int i, j;
  
  scanf("%d%d", &H, &W);
  for (i = 0; i < H; i++)
    scanf("%s", meiro[i]);

  for (i = 0; i < H; i++) {
    for (j = 0; j < W; j++) {
      if (meiro[i][j]=='s') {
	SR = i;
	SC = j;
      }
    }
  }

  dfs('1');
  dfs('2');
  if (dfs('3'))
    printf("YES\n");
  else
    printf("NO\n");
  
  return 0;
}
