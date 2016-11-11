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

int N;
int Pa, Pb;

bool simulate(int[] A, int[] B){
  int Sa, Sb;
  foreach (i; 0..N-1) {
    int a = Pa > uniform(0, 1000) ? 0 : uniform(1, N-i);
    int b = Pb > uniform(0, 1000) ? 0 : uniform(1, N-i);
    if (A[a] > B[b])
      Sa += A[a]+B[b];
    else if (B[b] > A[a])
      Sb += A[a]+B[b];
    A = A[0..a] ~ A[a+1..$];
    B = B[0..b] ~ B[b+1..$];
  }
  if (A[0] > B[0])
    Sa += A[0]+B[0];
  else if (B[0] > A[0])
    Sb += A[0]+B[0];
  return Sa > Sb;
}

void main() {
  auto input = readln.split;
  N = input[0].to!int;
  Pa = (input[1]~"000")[2..5].to!int;
  Pb = (input[2]~"000")[2..5].to!int;
  auto A = readln.split.map!(to!int).array.sort;
  auto B = readln.split.map!(to!int).array.sort;
  int ans = 0;
  int times = 20000;
  foreach (i; 0..times)
    if (simulate(A, B))
      ans += 1;
  writeln(ans.to!double / times);
}

