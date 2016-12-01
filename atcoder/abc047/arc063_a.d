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
  auto S = readln.chomp;
  char c = S[0];
  int ans = 0;
  foreach (s; S)
    if (s != c) {
      ans += 1;
      c = s;
    }
  writeln(ans);
}
