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


struct UnionFind {
  int n;
  int[] table;

  this (int N) {
    n = N;
    table = new int[](n);
    foreach (i; 0..n)
      table[i] = -1;
  }

  void unite(int x, int y) {
    x = find(x);
    y = find(y);
    if (x == y) return;
    if (table[x] < table[y]) swap(x, y);
    table[y] += table[x];
    table[x] = y;
  }

  int find(int x) {
    if (table[x] < 0)
      return x;
    return table[x] = find(table[x]);
  }
}

void main() {
  auto s = readln.split.map!(to!int);
  auto N = s[0];
  auto K = s[1];
  auto L = s[2];

  auto uf1 = new UnionFind(N);
  foreach (k; 0..K) {
    s = readln.split.map!(to!int);
    uf1.unite(s[0]-1, s[1]-1);
  }
  auto uf2 = new UnionFind(N);
  foreach (l; 0..L) {
    s = readln.split.map!(to!int);
    uf2.unite(s[0]-1, s[1]-1);
  }

  int[Tuple!(int, int)] cnt;
  foreach (n; 0..N) {
    auto t = tuple(uf1.find(n), uf2.find(n));
    if (t in cnt)
      cnt[t]++;
    else
      cnt[t] = 1;
  }

  iota(N).map!(n => (cnt[tuple(uf1.find(n), uf2.find(n))]).to!string).join(" ").writeln;

}
