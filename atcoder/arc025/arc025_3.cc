#include <bits/stdc++.h>
using namespace std;

const int INF = 1 << 30;
int N, M, R, T;
vector<pair<int, int> > adj[2501];
int dist[2501][2501] ;

void dijkstra(int s) {
    for (int i = 0; i < N; i++)
        dist[s][i] = INF;
    dist[s][s] = 0;

    priority_queue<pair<int, int>, vector<pair<int, int> >, greater<pair<int, int> > > q;
    q.push(make_pair(0, s));

    while (!q.empty()) {
        int cost, from;
        cost = q.top().first;
        from = q.top().second;
        q.pop();

        if (cost > dist[s][from])
            continue;

        for (int i = 0; i < adj[from].size(); i++) {
            //for (auto n: adj[from]) {
            int nc = cost + adj[from][i].first;
            int to = adj[from][i].second;
            if (dist[s][to] <= nc)
                continue;
            dist[s][to] = nc;
            q.push(make_pair(nc, to));
        }
    }
}

int main() {
    cin >> N >> M >> R >> T;
    for (int i = 0; i < M; i++) {
        int a, b, c;
        cin >> a >> b >> c;
        adj[a-1].push_back(make_pair(c, b-1));
        adj[b-1].push_back(make_pair(c, a-1));
    }


    vector<double> turtle[2501];
    vector<double> rabbit_s[2501];
    for (int i = 0; i < N; i++) {
        dijkstra(i);
        for (int j = 0; j < N ; j++) {
            turtle[i].push_back((double)dist[i][j] / T);
            rabbit_s[i].push_back((double)dist[i][j] / R);
        }
        sort(rabbit_s[i].begin(), rabbit_s[i].end());
    }

    long long int ans = 0;
    for (int a = 0; a < N; a++) {
        for (int c = 0; c < N; c++) {
            if (a == c) continue;
            double t = turtle[a][c];
            ans += N - (int)(upper_bound(rabbit_s[c].begin(), rabbit_s[c].end(), t) - rabbit_s[c].begin());
            if (T > R) ans--;
        }
    }

    cout << ans << endl;
}
