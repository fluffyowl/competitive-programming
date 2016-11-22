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


class Kosaraju {
  int N;
  int[][] adj;
  int[][] rev_adj;
  int[] group;
  bool[] group_prev;
  int[][] group_n;

  this(int n) {
    N = n;
    adj = new int[][](N);
    rev_adj = new int[][](N);
    group = new int[](N);
  }

  void add_edge(int from, int to) {
    adj[from] ~= to;
    rev_adj[to] ~= from;
  }

  void run() {
    int[] ord;
    auto used = new bool[](N);
    foreach (i; 0..N)
      if (!used[i])
        dfs1(i, ord, used);
    foreach (i; 0..N) used[i] = false;
    auto g_num = 0;
    foreach (i; iota(N-1, -1, -1))
      if (!used[ord[i]]) {
        dfs2(ord[i], g_num, used);
        g_num += 1;
      }
    group_n = new int[][](group.reduce!(max)+1);
    foreach (i; 0..N)
      group_n[group[i]] ~= i;
    group_prev = new bool[](group.reduce!(max)+1);
    foreach (i; 0..N)
      foreach (j; adj[i])
        if (group[i] != group[j])
          group_prev[group[j]] = true;
  }
  
  void dfs1(int from, ref int[] ord, ref bool[] used) {
    if (used[from]) return;
    used[from] = true;
    foreach (to; adj[from]) 
      if (!used[to])
        dfs1(to, ord, used);
    ord ~= from;
  }

  void dfs2(int from, int g_num, ref bool[] used) {
    if (used[from]) return;
    used[from] = true;
    group[from] = g_num;
    foreach (to; rev_adj[from])
      if (!used[to])
        dfs2(to, g_num, used);
  }

}

void main() {
  auto N = readln.chomp.to!int;
  auto ks = new Kosaraju(N);
  auto L = new int[](N);
  foreach (i; 0..N) {
    auto LS = readln.split.map!(to!int);
    L[i] = LS[0];
    if (LS[1]-1 != i) ks.add_edge(LS[1]-1, i);
  }
  ks.run();
  real ans = 0;
  foreach (g; 0..ks.group_n.length) {
    ans += ks.group_n[g].map!(n => L[n]).sum/2.0;
    if (!ks.group_prev[g])
      ans += ks.group_n[g].map!(n => L[n]).reduce!(min)/2.0;
  }
  writefln("%.1f", ans);
}
