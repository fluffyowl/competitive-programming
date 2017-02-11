#include <bits/stdc++.h>
using namespace std;

int main() {
    const double INF = pow(2.0, 40);

    int N;
    int X[1010], Y[1010], T[1010], R[1010];
    cin >> N;
    for (int i = 0; i < N; i++) {
        cin >> X[i] >> Y[i] >> T[i] >> R[i];
    }


    double cost[1010][1010];
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            double d = sqrt((double)((X[i]-X[j])*(X[i]-X[j]) + (Y[i]-Y[j])*(Y[i]-Y[j])));
            cost[i][j] = d / min(T[i], R[j]);
            //cout << cost[i][j] << endl;
        }

    bool used[1010] = {0};

    vector<double> dist(N);
    dist[0] = 0.0;
    for (int i = 1; i < N; i++)
        dist[i] = INF;

    while (true) {
        int mini = -1;
        for (int i = 0; i < N; i++) {
            if (!used[i] && (mini == -1 || dist[i] <= dist[mini])) {
                mini = i;
            }
        }
        if (mini == -1) break;
        used[mini] = true;

        for (int j = 0; j < N; j++)
            dist[j] = min(dist[j], dist[mini] + cost[mini][j]);


    }

    sort(dist.begin(), dist.end());
    double ans = 0.0;
    for (int i = 1; i < N; i++) {
        ans = max(ans, dist[i]+N-i-1);
    }

    cout << fixed << setprecision(10) << ans << endl;
}
