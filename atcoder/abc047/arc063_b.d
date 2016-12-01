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

void main() {
  auto input = readln.split.map!(to!int);
  int N = input[0];
  int T = input[1];
  auto A = readln.split.map!(to!int).array;
  auto M = new int[](N);

  M[N-1] = A[N-1];
  foreach (i; iota(N-2, -1, -1))
    M[i] = max(M[i+1], A[i]);

  auto L = new int[](N);
  int m = 0;
  foreach (i; iota(N-1)) {
    L[i] = M[i+1] - A[i];
    m = max(m, L[i]);
  }

  int ans = 0;
  foreach (i; iota(N-1))
    if (L[i] == m)
      ans++;
  writeln(ans);
}
