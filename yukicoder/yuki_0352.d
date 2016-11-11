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
  double ans = 2.0;

  foreach (m; iota(2, N)) {
    ans += 2.0/(m+1);
    foreach (i; iota(1, m+1))
      foreach (j; iota(i+1, m+1))
        ans += i*j*2.0/(m*(m+1));
  }
  writef("%.06f", ans);
}

