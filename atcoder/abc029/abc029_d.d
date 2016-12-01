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
  auto S = readln.chomp;
  auto N = S.length;
  auto dp = new long[][][](N+1, 2, 10);
  dp[0][0][0] = 1;
  foreach (i; 0..N)
    foreach (j; 0..2)
      foreach (k; 0..9) {
        auto digit = j ? 9 : (S[i]-'0').to!int;
        foreach (d; 0..digit+1)
          dp[i+1][j||(d<digit)][k+(d==1)] += dp[i][j][k];
      }

  long ans = 0;
  foreach (j; 0..2)
    foreach (k; 1..10)
      ans += dp[N][j][k] * k;

  writeln(ans);
  
}
