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
  int N = readln.chomp.to!int;
  auto A = readln.split.map!(to!int);

  auto dp = new double[][][](N+1, N+1, N+1);
  dp[0][0][0] = 0.0;

  foreach (i; iota(N+1))
    foreach (j; iota(N+1))
      foreach (k; iota(N+1)) {
        if (i+j+k == 0)
          continue;
        dp[i][j][k] = N*1.0/(i+j+k);
        if (k-1 >= 0)
          dp[i][j][k] += dp[i][j][k-1] * (k*1.0/(i+j+k));
        if (j-1 >= 0 && k+1 <= N)
          dp[i][j][k] += dp[i][j-1][k+1] * (j*1.0/(i+j+k));
        if (i-1 >= 0 && j+1 <= N)
          dp[i][j][k] += dp[i-1][j+1][k] * (i*1.0/(i+j+k));
      }
            
  int[4] count;
  foreach (a; A)
    count[min(a, 3)] += 1;
  writef("%.07f", dp[count[0]][count[1]][count[2]]);
}

