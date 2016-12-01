import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  auto input = readln().split.map!(to!int);
  int N = input[0];
  int M = input[1];
  int[int] ends;
  int[][] dist = new int[][](N, N);
  const int INF = int.max/3;
  foreach (i; iota(N))
    foreach (j; iota(N))
      dist[i][j] = (i==j)? 0:INF;

  int u, v, c;
  foreach (i; iota(M)) {
    input = readln().split.map!(to!int);
    u = input[0]-1;
    v = input[1]-1;
    c = input[2];
    if (u == 0)
      ends[v] = c;
    else if (v == 0)
      ends[u] = c;
    else {
      dist[u][v] = c;
      dist[v][u] = c;
    }
  }

  foreach (i; iota(N))
    foreach (j; iota(N))
      foreach (k; iota(N))
	dist[j][k] = min(dist[j][k], dist[j][i] + dist[i][k]);

  int ans = INF;
  int[] e = ends.keys;
  for (int i = 0; i < e.length; i++)
    for (int j = i+1; j < e.length; j++)
      ans = min(ans, dist[e[i]][e[j]] + ends[e[i]] + ends[e[j]]);

  if (ans == INF)
    writeln("-1");
  else
    writeln(ans);
}
