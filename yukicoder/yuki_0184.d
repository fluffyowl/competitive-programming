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
  //auto N = readln.chomp.to!int;
  readln;
  auto A = readln.split.map!(to!long).array.sort.uniq.array;
  auto N = A.length.to!int;
  auto M = new int[][](N, 61);
  foreach (i, a; enumerate(A))
    foreach (j; 0..61) 
      M[i][j] = (A[i] >> j) % 2;

  auto step = 0;
  foreach (i; 0..min(61,N)) {
    //M.each!(writeln);
    //writeln;
    if (M[i][i] == 0) {
      auto mi = i;
      auto m = 60;
      foreach (j; i+step..N)
        foreach (k; i..61) 
          if (M[j][k] == 1) {
            if (k < m) {
              mi = j;
              m = k;
            }
            break;
          }
      swap(M[i], M[mi]);
      foreach (j; 0..N)
        swap(M[j][i], M[j][m]);
    }
    if (M[i][i] == 0) continue;

    foreach (j; i+1..N)
      if (M[j][i] == 1)
        foreach (k; i..61) {
          (M[j][k] ^= M[i][k]);
        }
  }

  //M.each!(writeln);
  int i = N - 1;
  long ans = N;
  while (i >= 0 && M[i].sum == 0) {
    i -= 1;
    ans -= 1;
  }
  writeln(2L^^ans);
}

