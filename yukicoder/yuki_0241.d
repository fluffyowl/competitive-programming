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
  int N = readln.chomp.to!int;
  auto A = iota(N).map!(_ => readln.chomp.to!int).array;
  auto S = iota(N).array;

  if (all(A.map!(a => a == A[0])) && A[0] < N) {
    writeln(-1);
    return;
  }
  
  foreach (i; iota(N))
    if (S[i] == A[i])
      foreach (j; iota(N))
        if (S[i] != A[j] && S[j] != A[i])
          swap(S[i], S[j]);

  foreach (s; S)
    writeln(s);
}

