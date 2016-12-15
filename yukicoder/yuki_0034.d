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
  auto s = readln.split.map!(to!int);
  auto N = s[0];
  auto V = s[1];
  auto Sc = s[2]-1;
  auto Sr = s[3]-1;
  auto Gc = s[4]-1;
  auto Gr = s[5]-1;
  auto B = iota(N).map!(_ => readln.split.map!(to!int).array).array;
  auto dp = new int[][][](6000, N, N);
  int[] dr = [0, 0, -1, 1];
  int[] dc = [-1, 1, 0, 0];
  int INF = 10^^9;

  foreach (k; 0..6000)
    foreach (i; 0..N)
      foreach (j; 0..N)
        dp[k][i][j] = (i == Sr && j == Sc) ? 0 : INF;

  foreach (k; 1..6000)
    foreach (i; 0..N)
      foreach (j; 0..N) {
        if (abs(Sr-i) + abs(Sc-j) > k) continue;
        foreach (d; 0..4) {
          auto nr = i + dr[d];
          auto nc = j + dc[d];
          if (nr >= 0 && nr < N && nc >= 0 && nc < N)
            dp[k][i][j] = min(dp[k][i][j], dp[k-1][nr][nc]+B[i][j]);
        }
      }

  foreach (k; 0..6000)
    if (dp[k][Gr][Gc] < V) {
      k.writeln;
      return;
    }
  writeln(-1);
}

