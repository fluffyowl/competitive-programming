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

class UnionFind {

  int N;
  int[] table;

  this(int n) {
    N = n;
    table = new int[](N);
    foreach(i; 0..N) table[i] = -1;
  }

  int find(int x) {
    return table[x] < 0 ? x : (table[x] = find(table[x]));
  }

  void unite(int x, int y) {
    x = find(x);
    y = find(y);
    if (x == y) return;
    if (table[x] < table[y]) swap(x, y);
    table[x] += table[y];
    table[y] = x;
  }

  void group(ref int[][] g) {
    auto group = new int[][](N);
    foreach (i; 0..N)
      g[find(i)] ~= i;
  }

}

void main() {
  auto input = readln.split.map!(to!int);
  auto N = input[0];
  auto M = input[1];

  auto lang = new int[][](M+1);
  foreach (i; 0..N) {
    input = readln.split.map!(to!int);
    if (input[0] == 0) { writeln("NO"); return;}
    foreach (j; 1..input[0]+1)
      lang[input[j]] ~= i;
  }

  auto uf = new UnionFind(N);
  foreach (i; 1..M+1)
    foreach (j; 1..lang[i].length)
      uf.unite(lang[i][0], lang[i][j]);
  writeln(uf.table.map!(x => x < 0).sum == 1 ? "YES" : "NO");
}
