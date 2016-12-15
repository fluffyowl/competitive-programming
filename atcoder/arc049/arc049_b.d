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
import core.bitop;


void main() {
  alias Tuple!(int, "x", int, "y", int, "c") point;
  auto N = readln.chomp.to!int;
  auto P = new point[](N);
  foreach (i; 0..N) {
    auto input = readln.split.map!(to!int);
    P[i] = point(input[0], input[1], input[2]);
  }

  real high = 10L^^12;
  real low = 0.0L;
  foreach (i; 0..200) {
    real upper_x = 2*10L^^5;
    real lower_x = -2*10L^^5;
    real upper_y = 2*10L^^5;
    real lower_y = -2*10L^^5;
    auto mid = (high + low) / 2.0;
    foreach (j; 0..N) {
      auto d = mid/P[j].c;
      upper_x = min(upper_x, P[j].x + d);
      lower_x = max(lower_x, P[j].x - d);
      upper_y = min(upper_y, P[j].y + d);
      lower_y = max(lower_y, P[j].y - d);
    }
    if (upper_x >= lower_x && upper_y >= lower_y)
      high = mid;
    else
      low = mid;
  }
  writefln("%.5f", high);
}
