#include <utility>
#include <iostream>
#include <vector>
#include <stack>
#include <queue>

using namespace std;

struct Edge {
  int to;
  long long int cost;
  Edge(int to, long long int cost) {
    this->to = to;
    this->cost = cost;
  }
  bool operator<( const Edge& other ) const {
    return cost < other.cost;
  }
  bool operator>( const Edge& other ) const {
    return cost > other.cost;
  }
};

int main() {
  int N, M, a, b;
  long long int c;
  long long int towns[100001];
  vector<vector<Edge> > adj(100001, vector<Edge>());
  cin >> N >> M;
  for (int i = 0; i < N; i++) {
    cin >> towns[i];
  }
  for (int i = 0; i < M; i++) {
    cin >> a >> b >> c;
    adj[a-1].push_back(Edge(b-1, c));
    adj[b-1].push_back(Edge(a-1, c));
  }

  priority_queue<Edge, vector<Edge>, greater<Edge> > q;
  for (int i = 0; i < N; i++) {
    q.push(Edge(i, towns[i]));
  }
  long long int dist[100001];
  for (int i = 0; i < N; i++) {
    dist[i] = 1000000000000000L;
  }
  bool used[100001];

  while (!q.empty()) {
    Edge n = q.top();
    q.pop();
    if (used[n.to])
      continue;
    used[n.to] = true;
    dist[n.to] = min(dist[n.to], n.cost);
    for (auto m: adj[n.to]) {
      if (!used[m.to] && m.cost < dist[m.to]) {
        dist[m.to] = m.cost;
        q.push(Edge(m.to, dist[m.to]));
      }
    }
  }

  long long int ans = 0;
  for (int i = 0; i < N; i++)
    ans += dist[i];
  cout << ans << endl;
}
