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
  auto P = readln.chomp.to!int;
  auto N = iota(P+1).map!(_ => 0).array;
  N[0] = 1;

  auto dp = new long[][][][](P+2, 2, 3, 2); // keta, miman, 3wareru, 3tsuku
  dp[0][0][0][0] = 1;
  foreach (i; 0..P+1)
    foreach (j; 0..2)
      foreach (k; 0..3)
        foreach (l; 0..2) {
          auto digit = j ? 9 : N[i];
          foreach (d; 0..digit+1) {
            dp[i+1][j||(d<digit)][(k+d)%3][l||(d==3)] += dp[i][j][k][l];
          }
        }

  long ans = 0;
  foreach (k; 0..3)
    foreach (l; 0..2)
      if (k == 0 || l > 0)
        ans += dp[P+1][1][k][l];

  writeln(ans-1);

}

