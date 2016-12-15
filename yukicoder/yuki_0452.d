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


int N, M;

int count_diff(ref int[] A, ref int[] B) {
  A.sort();
  B.sort();
  int pa, pb, ret;
  while (pa < N && pb < N) {
    if (A[pa] == B[pb]) {ret++; pa++; pb++;}
    else if (A[pa] < B[pb]) pa++;
    else pb++;
  }
  return 2*N-ret;
}

void main() {
  auto input = readln.split.map!(to!int);
  N = input[0];
  M = input[1];
  auto B = new int[][][](M, 2*N+2, N);

  foreach (i; 0..M) {
    auto C = iota(N).map!(_ => readln.split.map!(to!int).array).array;
    foreach (j; 0..N) B[i][j] = C[j];
    foreach (j; N..2*N) foreach (k; 0..N) B[i][j][k] = C[k][j-N];
    foreach (j; 0..N) B[i][2*N][j] = C[j][j];
    foreach (j; 0..N) B[i][2*N+1][j] = C[j][N-j-1];
  }

  int ans = int.max;
  foreach (i; 0..M)
    foreach (j; i+1..M)
      foreach (a; 0..N*2+2)
        foreach (b; 0..N*2+2)
          ans = min(ans, count_diff(B[i][a], B[j][b]));

  writeln(ans-1);

}

