#include <stdio.h>
#include <queue>
#include <tuple>
#include <bits/stdc++.h>
using namespace std;

char meiro[505][505];
int H, W;
double brightness[10][500*510];
double EPS = 0.0000000001;
int dr[4] = {-1, 1, 0, 0};
int dc[4] = {0, 0, -1, 1};

int bfs(int sr, int sc, int gr, int gc) {
  queue<tuple<int,int,int>> que;
  que.emplace(sr, sc, 0);
  int r, c, depth, nr, nc;
  int i;
  char masu;
  bool visited[505][505];
  memset(visited, false, sizeof(visited));

  while (!que.empty()) {
    tie(r, c, depth) = que.front();
    que.pop();
    if (r == gr && c == gc)
      return depth;
    if (visited[r][c])
      continue;
    visited[r][c] = true;

    for (i = 0; i < 4; i++) {
      nr = r + dr[i];
      nc = c + dc[i];
      if (meiro[nr][nc] == '#')
	continue;
      if (visited[nr][nc])
	continue;
      que.emplace(nr, nc, depth+1);
    }
  }
  return -1;
}

int main() {
  int i, j;
  int sr, sc, cr, cc, gr, gc;
 
  scanf("%d%d", &H, &W);
  for (i = 0; i < H; i++)
    scanf("%s", meiro[i]);

  for (i = 0; i < H; i++) {
    for (j = 0; j < W; j++) {
      if (meiro[i][j]=='S') {
	sr = i;
	sc = j;
      }
      if (meiro[i][j]=='C') {
	cr = i;
	cc = j;
      }
      if (meiro[i][j]=='G') {
	gr = i;
	gc = j;
      }
    }
  }

  int d1 = bfs(sr, sc, cr, cc);
  int d2 = bfs(cr, cc, gr, gc);
  if (d1 == -1 || d2 == -1)
    printf("-1\n");
  else
    printf("%d\n", d1+d2);
  return 0;
}
