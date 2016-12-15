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


void main() {
  auto N = readln.chomp.to!int;
  auto adj = new int[][](N);
  foreach (_; 0..N-1) {
    auto input = readln.split.map!(to!int);
    adj[input[0]-1] ~= input[1]-1;
    adj[input[1]-1] ~= input[0]-1;
  }

  auto depth = new int[](N);
  auto dp = new int[][](20, N);
  void dfs(int n, int p, int d) {
    dp[0][n] = p;
    depth[n] = d;
    foreach (m; adj[n])
      if (m != p)
        dfs(m, n, d+1);
  }
  dfs(0, -1, 0);

  foreach (k; 0..19)
    foreach (n; 0..N)
      dp[k+1][n] = (dp[k][n] == -1) ? -1 : dp[k][dp[k][n]];

  int lca(int a, int b) {
    if (depth[a] < depth[b]) swap(a, b);
    auto orig_a = a;
    auto orig_b = b;
    while (depth[a] > depth[b]){
      int K = 19;
      foreach (k; iota(K, -1, -1))
        if (2^^k <= depth[a] - depth[b]) {
          a = dp[k][a];
          K = k;
        }
    }
    if (a == b)
      return max(depth[orig_a]-depth[b], depth[orig_b]-depth[a])+1;
    while (dp[0][a] != dp[0][b]) {
      int K = 19;
      foreach (k; iota(K, -1, -1))
        if (dp[k][a] != dp[k][b]) {
          a = dp[k][a];
          b = dp[k][b];
          K = k;
        }
    }
    return depth[orig_a] + depth[orig_b]  - 2*depth[dp[0][a]] + 1;
  }

  auto Q = readln.chomp.to!int;
  foreach (_; 0..Q) {
    auto input = readln.split.map!(to!int);
    lca(input[0]-1, input[1]-1).writeln;
  }
}
