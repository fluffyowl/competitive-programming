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
import std.bigint;


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
  auto W = readln.chomp.to!int;
  auto N = readln.chomp.to!int;
  auto J = readln.split.map!(to!int);
  auto M = readln.chomp.to!int;
  auto C = readln.split.map!(to!int);

  auto source = N + M;
  auto sink = source + 1;
  auto ff = new FordFulkerson(N+M+2, source, sink);
  foreach (i; 0..N) ff.add_edge(source, i, J[i]);
  foreach (i; 0..M) ff.add_edge(N+i, sink, C[i]);
  foreach (i; 0..M) {
    auto q = readln.split.map!(x => x.to!int-1).array[1..$];
    foreach (j; 0..N)
      if (find(q, j).empty)
        ff.add_edge(j, N+i, J[j]);
  }

  writeln(ff.run() >= W ? "SHIROBAKO" : "BANSAKUTSUKITA");
}

