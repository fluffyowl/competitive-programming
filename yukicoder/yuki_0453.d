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
  auto input = readln.split.map!(to!real);
  auto C = input[0];
  auto D = input[1];

  auto x = 20*C/13 - 8*D/13;
  auto y = -7*C/13 + 21*D/13;
  if (x >= 0 && y >= 0)
    writefln("%.7f", 1000*x+2000*y);
  else if (7*C/2 >= 7*D/5)
    writefln("%.7f", 1000*4*D);
  else
    writefln("%.7f", 2000*7*C/2);

}

