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
import core.bitop;


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
    flow[to][from] = cap;
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
  auto s = readln.split.map!(to!int);
  auto N = s[0];
  auto G = s[1];
  auto E = s[2];
  auto P = readln.split.map!(to!int).array;
  int sink = 0;
  int source = N;
  auto ff = new FordFulkerson(N+1, sink, source);
  foreach (i; 0..E) {
    s = readln.split.map!(to!int);
    ff.add_edge(s[0], s[1], 1);
  }
  foreach (p; P)
    ff.add_edge(p, source, 1);

  ff.run.writeln;
}
