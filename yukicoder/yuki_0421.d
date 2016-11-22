import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;
import std.math;
import std.container;
import std.numeric;


class FordFulkerson {
  int N, source, sink;
  int[][] adj;
  int[][] flow;
  bool[] used;

  this(int n, int s, int t) {
    N = n;
    source = s;
    sink = t;
    assert (s >= 0 && s < N && t >= 0 && t < N);
    adj = new int[][](N);
    flow = new int[][](N, N);
    used = new bool[](N);
  }

  void add_edge(int from, int to, int cap) {
    adj[from] ~= to;
    adj[to] ~= from;
    flow[from][to] = cap;
  }

  int dfs(int v, int min_cap) {
    if (v == sink)
      return min_cap;
    if (used[v])
      return 0;
    used[v] = true;
    foreach (to; adj[v]) {
      if (!used[to] && flow[v][to] > 0) {
        auto bottleneck = dfs(to, min(min_cap, flow[v][to]));
        if (bottleneck == 0) continue;
        flow[v][to] -= bottleneck;
        flow[to][v] += bottleneck;
        return bottleneck;
      }
    }
    return 0;
  }

  int run() {
    int ret = 0;
    while (true) {
      foreach (i; 0..N) used[i] = false;
      int f = dfs(source, int.max);
      if (f > 0)
        ret += f;
      else
        return ret;
    }
  }
}

void main() {
  auto input = readln.split.map!(to!int);
  auto H = input[0];
  auto W = input[1];
  auto B = iota(H).map!(_ => readln.chomp).array;

  auto source = H*W, sink = H*W+1;
  auto ff = new FordFulkerson(H*W+2, source, sink);
  int[4] dx = [0, 0, -1, 1];
  int[4] dy = [-1, 1, 0, 0];
  auto count_b = 0, count_c = 0;
  foreach (i; 0..H*W) {
    auto r = i / W;
    auto c = i % W;
    if (B[r][c] == 'b') {
      count_b += 1;
      ff.add_edge(source, i, 1);
      foreach (d; 0..4) {
        auto nr = r + dx[d];
        auto nc = c + dy[d];
        auto j = nr * W + nc;
        if (nr >= 0 && nr < H && nc >= 0 && nc < W && B[nr][nc] == 'w')
          ff.add_edge(i, j, 1);
      }
    }
    else if (B[r][c] == 'w') {
      count_c += 1;
      ff.add_edge(i, sink, 1);
    }
  }

  auto pairs = ff.run();
  auto amari_pairs = min(count_b, count_c) - pairs;
  auto single = max(count_b, count_c) - pairs - amari_pairs;
  writeln(pairs*100 + amari_pairs*10 + single);
}

