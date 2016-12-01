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


void main() {
  const long INF = 10^^30;
  auto input = readln.split;
  auto N = input[0].to!int;
  auto M = input[1].to!int;
  auto adj = new int[][](N);
  auto d = new long[][](N, N);
  foreach (i; 0..N)
    foreach (j; 0..N)
      d[i][j] = (i == j) ? 0 : INF;
  foreach (i; 0..M) {
    input = readln.split;
    auto a = input[0].to!int - 1;
    auto b = input[1].to!int - 1;
    auto c = input[2].to!long;
    adj[a] ~= b;
    adj[b] ~= a;
    d[a][b] = c;
    d[b][a] = c;
  }
  foreach (i; 0..N)
    foreach (j; 0..N)
      foreach (k; 0..N)
        d[j][k] = min(d[j][k], d[j][i] + d[i][k]);

  auto Q = readln.chomp.to!int;
  foreach (q; 0..Q) {
    input = readln.split;
    auto a = input[0].to!int - 1;
    auto b = input[1].to!int - 1;
    auto c = input[2].to!long;
    if (d[a][b] <= c) {
      writeln(d.map!(sum).sum/2);
      continue;
    }
    d[a][b] = c;
    d[b][a] = c;
    foreach (x; [a, b])
      foreach (i; 0..N)
        foreach (j; 0..N) {
          d[i][j] = min(d[i][j], d[i][x]+d[x][j]);
      }
    writeln(d.map!(sum).sum/2);
  }
}
