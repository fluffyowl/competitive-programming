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
  auto N = readln.chomp.to!int;

  alias Tuple!(int, "x", int, "y") point;
  point[] check;
  foreach (x; iota(-20, 21))
    foreach (y; iota(-20, 21))
      if (x*x+y*y < 400)
	check ~= point(x, y);

  auto mem = new bool[][](20001, 20001);
  int ans = 0;

  foreach (i; 0..N) {
    auto input = readln.split.map!(to!int);
    auto x = input[0];
    auto y = input[1];
    bool flag = true;
    foreach (p; check) {
      if (x+p.x < 0 || x+p.x >= 20001 || y+p.y < 0 || y+p.y >= 20001)
	continue;
      if (mem[x+p.x][y+p.y]) {
	flag = false;
	break;
      }
    }
    if (flag) {
      ans += 1;
      mem[x][y] = true;
    }
  }

  writeln(ans);
}

