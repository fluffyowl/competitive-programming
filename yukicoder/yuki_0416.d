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

struct UnionFind {
  int[] n_group;
  int[][] group_n;
  
  this (int n) {
    n_group = iota(n).array;
    group_n = iota(n).map!(i => [i].array).array;
  }

  void unite(int x, int y) {
    int gx = find(x);
    int gy = find(y);
    if (gx == gy) return;
    if (group_n[gx].length < group_n[gy].length) swap(gx, gy);
    foreach (ye; group_n[gy]) {
      n_group[ye] = gx;
      group_n[gx] ~= ye;
    }
  }

  int find(int x) {
    return n_group[x];
  }

  bool is_peer(int x, int y) {
    return find(x) == find(y);
  }
}


void main() {
  auto input = readln.split.map!(to!int);
  auto N = input[0];
  auto M = input[1];
  auto Q = input[2];
  auto AB = iota(M).map!(_ => readln.split.map!(x => x.to!int-1).array).array;
  auto CD = iota(Q).map!(_ => readln.split.map!(x => x.to!int-1).array).array;
  
  bool[int][int] destroyed;
  foreach (cd; CD)
    destroyed[cd[0]][cd[1]] = true;
  
  auto uf = UnionFind(N);

  foreach(ab; AB) {
    int a = ab[0];
    int b = ab[1];
    if (a in destroyed && b in destroyed[a]) continue;
    uf.unite(a, b);
  }

  auto ans = new int[](N);
  uf.group_n[uf.find(0)].each!(n => ans[n] = -1);

  foreach (q; iota(Q-1, -1, -1)) {
    int c = CD[q][0];
    int d = CD[q][1];
    if (uf.find(c) == uf.find(d))
      continue;
    else if (uf.find(0) == uf.find(c))
      foreach (n; uf.group_n[uf.find(d)])
        ans[n] = q+1;
    else if (uf.find(0) == uf.find(d))
      foreach (n; uf.group_n[uf.find(c)])
        ans[n] = q+1;
    uf.unite(c, d);
  }
  
  ans[1..$].each!(writeln);
}

