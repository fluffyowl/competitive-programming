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

void main() {
  auto input = readln.split.map!(to!int);
  int N = input[0];
  int K = input[1];
  auto enemies = new int[][](N, 3);
  foreach (i; iota(N))
    enemies[i] = readln.split.map!(to!int).array;

  auto imos = new int[][](2000, 2000);
  foreach (i; iota(K)) {
    input = readln.split.map!(to!int);
    int x = input[0]+500;
    int y = input[1]+500;
    int dx = input[2];
    int dy = input[3];
    int d = input[4];
    imos[x][y] += d;
    imos[x+dx+1][y] -= d;
    imos[x][y+dy+1] -= d;
    imos[x+dx+1][y+dy+1] += d;
  }

  foreach (i; iota(1, 2000))
    foreach (j; iota(2000))
      imos[i][j] += imos[i-1][j];
  
  foreach (i; iota(2000))
    foreach (j; iota(1, 2000))
      imos[i][j] += imos[i][j-1];

  int ans = 0;
  foreach (e; enemies)
    ans += max(0, e[2]-imos[e[0]+500][e[1]+500]);
  writeln(ans);
}

