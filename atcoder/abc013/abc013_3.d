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
  auto input = readln.split.map!(to!long);
  auto N = input[0];
  auto H = input[1];
  input = readln.split.map!(to!long);
  auto A = input[0];
  auto B = input[1];
  auto C = input[2];
  auto D = input[3];
  auto E = input[4];

  long ans = long.max;
  foreach (x; 0..N+1) {
    long y = max(((-H-B*x+E*N-E*x)*1.0L/(D+E) + 1).to!long, 0);
    if (x + y <= N) {
      ans = min(ans, A*x+C*y);
    }
  }

  writeln(ans);

}
