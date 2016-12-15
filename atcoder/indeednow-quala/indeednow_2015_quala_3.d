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
  auto N = readln.chomp.to!int;
  auto S = iota(N).map!(_ => readln.chomp.to!int).array;
  auto Q = readln.chomp.to!int;
  auto K = iota(Q).map!(_ => readln.chomp.to!int).array;

  int manten = 1000001;
  auto A = new int[](manten);
  foreach (s; S)
    A[s] -= (s != 0) ? 1 : 0;
  foreach (i; iota(manten-2, -1, -1))
    A[i] += A[i+1];

  auto B = A.assumeSorted;
  foreach (k; K)
    B.lowerBound(-k).length.writeln;
}
