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
  int W = input[0];
  int H = input[1];
  int N = input[2];
  int[4] A = [0, W, 0, H];
  foreach (i; 0..N) {
    input = readln.split.map!(to!int);
    if (input[2]== 1)
      A[0] = max(A[0], input[0]);
    else if (input[2]== 2)
      A[1] = min(A[1], input[0]);
    else if (input[2]== 3)
      A[2] = max(A[2], input[1]);
    else if (input[2]== 4)
      A[3] = min(A[3], input[1]);
  }

  if (A[0] >= A[1] || A[2] >= A[3])
    writeln(0);
  else
    writeln((A[1]-A[0])*(A[3]-A[2]));
}
