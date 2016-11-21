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
  real EPS = (10.0L)^^(-12);
  auto T = readln.chomp.to!int;

  foreach (t; 0..T) {
    readln();
    foreach (i; 0..6) {
      auto input = readln.split.map!(to!real);
      auto x = input[0];
      auto y = input[1];
      if (abs(1.0L - x) < EPS) {
        writeln("0.0000000");
        foreach (j; i+1..6)
          readln();
        break;
      }
      auto deg = atan2(y, x) * 180.0L / PI;
      if (-1.0L < deg && deg < 51.0L) {
        writefln("%.7f", deg);
        foreach (j; i+1..6)
          readln();
        break;
      }
    }
  }
}

