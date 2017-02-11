#include <bits/stdc++.h>
using namespace std;

const int INF = 1 << 20;
int R, C, K, sr, sc, cr, cc, gr, gc;
int cost[3][50][50][110];
char B[50][50];
int dr[4] = {0, 0, 1, -1};
int dc[4] = {1, -1, 0, 0};
bool used[50][50];

int main() {
    cin >> R >> C >> K;
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            cin >> B[i][j];
            if (B[i][j] == 'S') sr = i, sc = j;
            if (B[i][j] == 'C') cr = i, cc = j;
            if (B[i][j] == 'G') gr = i, gc = j;
        }
    }

    for (int i = 0; i < 3; i++)
        for (int j = 0; j < R; j++)
            for (int k = 0; k < C; k++)
                for (int l = 0; l < K+5; l++)
                    cost[i][j][k][l] = INF;

    cost[0][sr][sc][0] = 0;
    cost[1][cr][cc][0] = 0;
    cost[2][gr][gc][0] = 0;

    int r, c, e;
    for (int i = 0; i < 3; i++) {
        queue<tuple<int,int, int>> q;
        if (i == 0) q.push(make_tuple(sr, sc, 0));
        if (i == 1) q.push(make_tuple(cr, cc, 0));
        if (i == 2) q.push(make_tuple(gr, gc, 0));

        while (!q.empty()) {
            tie(r, c, e) = q.front();
            q.pop();
            for (int d = 0; d < 4; d++) {
                int nr = r + dr[d];
                int nc = c + dc[d];
                if (nr < 0 || nr >= R || nc < 0 || nc >= C) continue;
                if (B[nr][nc] == 'T') continue;
                int ne = (B[nr][nc] == 'E') ? e+1 : e;
                if (ne > K+5) continue;
                if (cost[i][nr][nc][ne] > cost[i][r][c][e] + 1) {
                    cost[i][nr][nc][ne] = cost[i][r][c][e] + 1;
                    q.push(make_tuple(nr, nc, ne));
                }
            }
        }
    }


    for (int i = 0; i < 3; i++)
        for (int r = 0; r < R; r++)
            for (int c = 0; c < C; c++)
                for (int k = 1; k < K+5; k++)
                    cost[i][r][c][k] = min(cost[i][r][c][k], cost[i][r][c][k-1]);


    int ans = INF;
    for (int r = 0; r < R; r++) {
        for (int c = 0; c < C; c++) {
            for (int x = 0; x <= K; x++) {
                for (int y = 0; y <= K-x; y++) {
                    int z = K - x - y;
                    int tmp;
                    if (B[r][c] == 'E')
                        tmp = cost[0][r][c][x] + cost[1][r][c][y+1]*2 + cost[2][r][c][z+1];
                    else
                        tmp = cost[0][r][c][x] + cost[1][r][c][y]*2 + cost[2][r][c][z];
                    ans = min(ans, tmp);
                }
            }


        }
    }

    if (ans == INF) cout << -1 << endl;
    else cout << ans << endl;
}
