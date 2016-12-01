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


long solve(string S) {
  auto N = S.length;
  auto dp = new long[][][][](N+1, 2, 2, 2);
  dp[0][0][0][0] = 1;
  foreach (i; 0..N)
    foreach (j; 0..2)
      foreach (k; 0..2)
        foreach (l; 0..2) {
          auto digit = j ? 9 : (S[i]-'0').to!int;
          foreach (d; 0..digit+1)
            dp[i+1][j||(d<digit)][k||(d==4)][l||(d==9)] += dp[i][j][k][l];
        }

  long ans = 0;
  foreach (j; 0..2)
    foreach (k; 0..2)
      foreach (l; 0..2)
        if (k || l)
          ans += dp[N][j][k][l];

  return ans;

}

void main() {
  auto input = readln.split;
  auto A = (BigInt(input[0]) - BigInt(1)).to!string;
  auto B = input[1];
  auto ans = solve(B) - solve(A);
  writeln(ans);
}
