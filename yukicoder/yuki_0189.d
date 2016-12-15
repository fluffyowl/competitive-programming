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


long mod = 10L^^9+9;

void solve(string S, ref long[][][] dp) {
  auto N = S.length;
  dp = new long[][][](N+1, 2, 1820); // keta, miman, 3wareru, 3tsuku, 8wareru
  dp[0][0][0] = 1L;
  foreach (i; 0..N)
    foreach (j; 0..2)
      foreach (k; 0..1801) {
        auto digit = j ? 9 : (S[i]-'0').to!int;
        foreach (d; 0..digit+1)
          (dp[i+1][j||(d<digit)][k+d] += dp[i][j][k]) %= mod;
      }
}

void main() {
  auto input = readln.split;
  auto A = input[0];
  auto B = input[1];
  long[][][] dp1, dp2;
  solve(A, dp1);
  solve(B, dp2);
  long ans = 0;
  foreach (k; 1..1820)
    (ans += ((dp1[A.length][0][k] + dp1[A.length][1][k]) *
             (dp2[B.length][0][k] + dp2[B.length][1][k]) % mod)) %= mod;
  writeln(ans);
}

