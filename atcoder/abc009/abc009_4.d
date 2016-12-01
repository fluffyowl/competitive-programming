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
  auto input = readln.split.map!(to!uint);
  auto K = input[0];
  auto M = input[1];
  auto A = readln.split.map!(to!uint).array;
  auto C = readln.split.map!(to!uint).array;
  auto D = new uint[][][](K, K, 2);
  foreach(i; 0..K)   D[0][i][0] = C[i];
  foreach(i; 0..K-1) D[i+1][i][0] = uint.max;
  auto ans = new uint[][](K, K);
  foreach(i; 0..K) ans[i][i] = uint.max;

  if (M <= K) { writeln(A[M-1]); return; }

  foreach (k; 0..30){
    if (M-K & (1 << k)) {
      auto new_ans = new uint[][](K, K);
      foreach (i; 0..K)
        foreach (j; 0..K)
          foreach (m; 0..K) 
            new_ans[i][j] ^= ans[i][m] & D[m][j][k%2];
      foreach (i; 0..K) foreach (j; 0..K) ans[i][j] = new_ans[i][j];
    }
    
    foreach (i; 0..K)
      foreach (j; 0..K)
        D[i][j][(k+1)%2] = 0;
    foreach (i; 0..K)
      foreach (j; 0..K)
        foreach (m; 0..K)
          D[i][j][(k+1)%2] ^= D[i][m][k%2] & D[m][j][k%2];
  }

  uint a = 0;
  foreach (i; 0..K)
    a ^= ans[0][i] & A[K-i-1];

  writeln(a);
}
