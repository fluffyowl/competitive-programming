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
import core.bitop;


void main() {
  auto input = readln.split.map!(to!int);
  auto N = input[0].to!int;
  auto K = input[1].to!int;
  auto P = iota(N).map!(_ => readln[0]).array;
  auto cnt = new int[](26);
  foreach (p; P) cnt[p-'A']++;

  if (N < K) {writeln(0); return;}
  foreach (i; 1..N/K+1)
    if (cnt.map!(c => min(c, i)).sum < i*K) {
      writeln(i-1);
      return;
    }
  writeln(N/K);
}
