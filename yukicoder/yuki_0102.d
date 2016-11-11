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
  auto a = readln.split.map!(a => (a.to!int)%4);
  writeln((a[0]^a[1]^a[2]^a[3]) == 0 ? "Jiro" : "Taro");
}

