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
  auto N = readln.chomp.to!int;
  auto C = iota(N).map!(_ => readln.chomp.to!int).array;
  auto F = new int[](N);

  foreach (i; 0..N)
    foreach (j; 0..N)
      if (i != j && C[i] % C[j] == 0)
        F[i] += 1;

  writefln("%.7f", F.map!(f => f%2==0 ? (f+2)*1.0L/(2*f+2) : 1.0L/2).reduce!"a+b");

}
