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
import core.bitop;



void main() {
  auto input = readln.split;
  auto N = input[0].to!int;
  auto D = input[1].to!long;

  int f2, f3, f5;
  while (D % 2 == 0) { D/= 2; f2 += 1; }
  while (D % 3 == 0) { D/= 3; f3 += 1; }
  while (D % 5 == 0) { D/= 5; f5 += 1; }
  if (D != 1) { writeln(0); return; }
  
  auto dp = new real[][][][](3, 65, 45, 35);
  foreach (n; 0..2)
    foreach (i; 0..65)
      foreach (j; 0..45)
        foreach (k; 0..35)
          dp[n][i][j][k] = 0.0L;
  dp[0][0][0][0] = 1.0L;
  
  foreach (n; 0..N) {
    
    foreach (i; 0..61)
      foreach (j; 0..41)
        foreach (k; 0..31)
          dp[(n+1)%2][i][j][k] = 0.0L;
    
    foreach (i; 0..61)
      foreach (j; 0..41)
        foreach (k; 0..31) {
          auto p = dp[n%2][i][j][k]/ 6.0L;
          dp[(n+1)%2][i][j][k] += p;
          dp[(n+1)%2][min(60, i+1)][j][k] += p;
          dp[(n+1)%2][i][min(40, j+1)][k] += p;
          dp[(n+1)%2][min(60, i+2)][j][k] += p;
          dp[(n+1)%2][i][j][min(30, k+1)] += p;
          dp[(n+1)%2][min(60, i+1)][min(40, j+1)][k] += p;
        }
  }
  
  real ans = 0.0L;
  foreach (i; f2..65)
    foreach (j; f3..45)
      foreach (k; f5..35) 
        ans += dp[N%2][i][j][k];
  writefln("%.12f", ans);
}
