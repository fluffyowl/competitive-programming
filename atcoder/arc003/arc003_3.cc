#include <bits/stdc++.h>
using namespace std;

int N, M, Sr, Sc, Gr, Gc;
int B[510][510];
double pow99[250010];
int dx[4] = {1, -1, 0, 0};
int dy[4] = {0, 0, 1, -1};


bool dfs(double limit) {
    queue<tuple<int, int, int>> q;
    q.push(make_tuple(Sr, Sc, 0));
    bool used[510][510] = {0};
    

    while (!q.empty()) {
        int nr, nc, nd;
        tie(nr, nc, nd) = q.front();
        q.pop();
        if (nr == Gr && nc == Gc)
            return true;
        if (used[nr][nc])
            continue;
        used[nr][nc] = true;
        
        for (int i = 0; i < 4; i++) {
            int mr = nr + dx[i];
            int mc = nc + dy[i];
            int md = nd + 1;
            if (mr < 0 || mr >= N || mc < 0 || mc >= M)
                continue;
            if (B[mr][mc] == (int)('#'-'0') || used[mr][mc])
                continue;
            if (B[mr][mc] * pow99[md] < limit)
                continue;
            q.push(make_tuple(mr, mc, md));
        }
    }

    return false;
}


int main() {
    cin >> N >> M;
    for (int i = 0; i < N; i++) {
        string s;
        cin >> s;
        for (int j = 0; j < M; j++) {
            B[i][j] = (int)(s[j] - '0');
            if (s[j] == 's') {Sr = i; Sc = j;}
            if (s[j] == 'g') {Gr = i; Gc = j;}
        }
    }

    pow99[0] = 1.0;
    for (int i = 1; i < 250005; i++) {
        pow99[i] = 0.99 * pow99[i-1];
    }

    double hi = 10.0;
    double lo = 0.0;
    for (int i = 0; i < 100; i++) {
        double mid = (hi + lo) / 2.0;
        if (dfs(mid)) lo = mid;
        else hi = mid;
    }

    if (!dfs(-1)) cout << -1 << endl;
    else cout << fixed << setprecision(10) << hi << endl;
}
