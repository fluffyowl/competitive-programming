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


long mod = 10L^^9+7;

long solve(string S) {
  auto N = S.length;
  auto dp = new long[][][][][](N+1, 2, 3, 2, 8); // keta, miman, 3wareru, 3tsuku, 8wareru
  dp[0][0][0][0][0] = 1L;
  foreach (i; 0..N)
    foreach (j; 0..2)
      foreach (k; 0..3)
        foreach (l; 0..2)
          foreach (m; 0..8) {
            auto digit = j ? 9 : (S[i]-'0').to!int;
            foreach (d; 0..digit+1)
              (dp[i+1][j||(d<digit)][(k+d)%3][l||(d==3)][(10*m+d)%8] += 
               dp[i][j][k][l][m]) %= mod;
          }

  long ans = 0;
  foreach (j; 0..2)
    foreach (k; 0..3)
      foreach (l; 0..2)
        foreach (m; 1..8)
          if (k == 0 || l > 0)
            (ans += dp[N][j][k][l][m]) %= mod;

  return ans;
  
}

void main() {
  auto input = readln.split;
  auto A = (BigInt(input[0]) - BigInt(1)).to!string;
  auto B = input[1];
  auto ans = (solve(B) - solve(A)) % mod;
  writeln(ans < 0 ? mod + ans : ans);
}

