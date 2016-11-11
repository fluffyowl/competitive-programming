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

void main() {
  int N = readln.chomp.to!int;
  auto A = readln.split.map!(to!int).array;

  foreach (i; 0..N-1) {
    int mv = int.max;
    int mj = -1;
    foreach (j; i+1..N) {
      int lcm = A[i]*A[j]/gcd(A[i], A[j]);
      if (lcm < mv) {
        mv = lcm;
        mj = j;
      }
      else if (lcm == mv && A[mj] > A[j])
        mj = j;
    }
    swap(A[i+1], A[mj]);
  }

  writeln(A.map!(to!string).join(" "));
}

