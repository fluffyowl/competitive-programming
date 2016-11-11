import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  auto input = readln().split;
  int N = input[0].to!int;
  double P = 1.0-input[1].to!double;
  double[] table = new double[](N+1);
  foreach (i; iota(N+1))
    table[i] = 1.0;
  
  foreach (i; iota(2, N+1))
    foreach(j; iota(i+i, N+1, i))
      table[j] *= P;

  double ans = 0.0;
  foreach (i; iota(2, N+1))
    ans += table[i];
  writef("%.07f", ans);
}
