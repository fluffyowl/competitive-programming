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
  auto A = input[0];
  auto B = input[1];
  if (A < B) swap(A, B);
  auto N = readln.chomp.to!int;
  foreach (_; 0..N) {
    input = readln.split.map!(to!real);
    auto C = input[0];
    auto D = input[1];
    if (C < D) swap(C, D);
    if (A < C && B < D) {
      "YES".writeln;
      continue;
    }
    real high = PI/2;
    real low = 0;
    foreach (i; 0..50) {
      auto mid = (high+low) / 2;
      if (A * sin(mid) + B * cos(mid) < D)
        low = mid;
      else
        high = mid;
    }
    auto tate = A * sin(high) + B * cos(high);
    auto yoko = A * cos(high) + B * sin(high);
    //writefln("D: %f / tate: %.7f", D, tate);
    //writefln("C: %f / yoko: %.7f", C, yoko);

    writeln((high > 0.00000001L && yoko <= C) ? "YES" : "NO");
  }
}
