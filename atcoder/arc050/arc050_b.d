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
  auto R = input[0];
  auto B = input[1];
  input = readln.split.map!(to!long);
  auto x = input[0];
  auto y = input[1];

  long f(long n) {return min(n, min(R/x, B)) + max(0, min(R-n*x, (B-n)/y));}
  long high = min(R/x, B);
  long low = 0L;
  while (high - low > 2) {
    auto mid1 = (high-low)/3 + low;
    auto mid2 = (high-low)/3*2 + low;
    if (f(mid1) >= f(mid2))
      high = mid2;
    else
      low = mid1;
  }
  writeln([low, low+1, low+2, low+3].map!(f).reduce!(max));
}
