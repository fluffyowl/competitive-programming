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


void main() {
  auto input = readln.split.map!(to!long);
  auto Sx = input[0];
  auto Sy = input[1];
  auto Gx = input[2];
  auto Gy = input[3];
  auto N = readln.chomp.to!int;
  auto x = new long[](N);
  auto y = new long[](N);
  auto r = new long[](N);
  foreach (i; 0..N) {
    input = readln.split.map!(to!long);
    x[i] = input[0];
    y[i] = input[1];
    r[i] = input[2];
  }

  auto edge = new real[][](N+2, N+2);
  foreach (i; 0..N+2) foreach (j; 0..N+2) edge[i][j] = (i == j) ? 0 : real.max;
  foreach (i; 0..N)
    foreach (j; i+1..N) {
      real d = max(0, sqrt((x[i]-x[j])^^2.to!real + (y[i]-y[j])^^2.to!real) - r[i] - r[j]);
      edge[i][j] = min(edge[i][j], d);
      edge[j][i] = min(edge[j][i], d);
    }
  foreach (i; 0..N) {
    real ds = sqrt((x[i]-Sx)^^2.to!real + (y[i]-Sy)^^2.to!real) - r[i];
    real dg = sqrt((x[i]-Gx)^^2.to!real + (y[i]-Gy)^^2.to!real) - r[i];
    edge[i][N] = max(min(ds, edge[N][i]), 0);
    edge[N][i] = max(min(ds, edge[i][N]), 0);
    edge[i][N+1] = max(min(dg, edge[i][N+1]), 0);
    edge[N+1][i] = max(min(dg, edge[N+1][i]), 0);
  }
  edge[N][N+1] = sqrt((Gx-Sx)^^2.to!real + (Gy-Sy)^^2.to!real);
  edge[N+1][N] = sqrt((Gx-Sx)^^2.to!real + (Gy-Sy)^^2.to!real);

  auto d = new real[](N+2);
  foreach (i; 0..N+2) d[i] = 10L^^15;
  d[N] = 0;
  auto used = new bool[](N+2);
  while (true) {
    int v = -1;
    foreach (u; 0..N+2)
      if (!used[u] && (v == -1 || d[u] < d[v]))
        v = u;
    if (v == -1)
      break;
    used[v] = true;
    foreach (u; 0..N+2)
      d[u] = min(d[u], d[v] + edge[v][u]);
  }

  writefln("%.9f", d[N+1]);
}
